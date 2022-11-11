import imaplib
import email
from email.header import decode_header

import os
import os.path

import time

"""
Generic library to handle applications that have email confirmation.
Useful links:
- 
"""
class EmailParserLib:
    ROBOT_LIBRARY_VERSION = 1.0

    IMAP_server = "imap.mail.yahoo.com"  # Yahoo IMAP server
    username = ''
    password = ''

    """
    Authenticating to email account.
    `@return` The imap object that can be used later to select other folders.
    """
    def authenticate(self):
        # Create an IMAP4 class with SSL 
        imap = imaplib.IMAP4_SSL(self.IMAP_server)
        # Authenticate
        imap.login(self.username, self.password)
        return imap
    
    """
    Selecting the desired folder, usually Inbox.
    `imap` Imap object
    `folder` The email folder to select
    `@return` A list of all the emails from the selected email folder.
    """
    def select_folder(self, imap, folder):
        # Select email folder
        status, messages = imap.select(folder)
        return messages
    
    """
    Waiting for the confirmation email to arrive in the Inbox folder.
    Here it is assumed that all the emails from Inbod folder will be cleanup before starting each test.
    @return The number of emails in the Inbox folder.
    """
    def wait_for_confirmation_email(self, imap):
        messages = self.select_folder(imap, 'INBOX')
        emails = int(messages[0])   # total number of emails
        while emails == 0:
            time.sleep(1)
            messages = self.select_folder(imap, 'INBOX')
            emails = int(messages[0])
        return str(emails)
    
    """
    Parsing a certain confirmation email from the list. The email is searched by index, and also by expected subject.
    It is assumed the email is an HTML email, and the content is saved in an HTML file to be later opened in the browser
    during the running of the test so that the test can click on the confirmation link and continue the test with the next steps.
    """
    def generate_email_html_file(self, emailIndex, expectedSubject):
        imap = self.authenticate()
        self.wait_for_confirmation_email(imap)
        res, msg = imap.fetch(str(emailIndex), "(RFC822)")
        for response in msg:
            if isinstance(response, tuple):
                # parse a bytes email into a message object
                msg = email.message_from_bytes(response[1])
                # decode the email subject
                subject, encoding = decode_header(msg["Subject"])[0]
                if isinstance(subject, bytes):
                    # if it's a bytes, decode to str
                    subject = subject.decode(encoding)
                # decode email sender
                sender, encoding = decode_header(msg.get("From"))[0]
                if isinstance(sender, bytes):
                    sender = sender.decode(encoding)
                # if the email message is multipart
                if msg.is_multipart():
                    # iterate over email parts
                    for part in msg.walk():
                        # extract content type of email
                        content_type = part.get_content_type()
                        try:
                            # get the email body
                            body = part.get_payload(decode=True).decode()
                        except:
                            pass
                else:
                    # extract content type of email
                    content_type = msg.get_content_type()
                    # get the email body
                    body = msg.get_payload(decode=True).decode()
                if content_type == "text/html":
                    # if it's HTML, parse the HTML for the links
                    if expectedSubject in subject:      # Find an email by its subject message
                        open('email.html', "w").write(body)
                    else:
                        return 'Error: Unexpected Email Subject'
        self.logout_from_email_server(imap)
    
    """
    Generic method to delete all the emails from a given folder (usually Inbox).
    """
    def delete_all_emails(self, folder):
        imap = self.authenticate()
        messages = self.select_folder(imap, folder)
        emails = int(messages[0])   # total number of emails
        if emails > 0:
            status, messages_id_list = imap.search(None, "ALL")
            # convert the string ids to list of email ids
            messages = messages_id_list[0].split(b' ')
            count =1
            for mail in messages:
                # mark the mail as deleted
                imap.store(mail, '+FLAGS', '\\Deleted')
                print(count, 'mail(s) deleted')
                count +=1
            # delete all the selected messages 
            imap.expunge()
            self.logout_from_email_server(imap)
            return 'All selected mails has been deleted'
        return 'Email folder already empty'
    
    def logout_from_email_server(self, imap):
        # close the mailbox
        imap.close()
        # logout from the server
        imap.logout()

    """
    Get absolute path of the HTML email saved in an HTML file.
    This is udeful if you want to open the e amail content in the browser, check its contents and click the confirmation link.
    """
    def get_email_file_path(self):
        return os.path.abspath("email.html")
    
    """
    Cleanup the generated html file and delete all emails from inbox before each run.
    It is recommended to use a test email so that there is no issue if all the emails will be deleted from Inbox.
    """
    def cleanup(self):
        if os.path.exists('email.html'):
            os.remove('email.html')
        self.delete_all_emails('INBOX')
