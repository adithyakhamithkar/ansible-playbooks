##What is John the Ripper?
John the Ripper is a fast password cracker tool that supports UNIX, Linux, Windows and Mac OS.

http://www.openwall.com/john/

![John](https://raw.githubusercontent.com/adithyakhamithkar/ansible/master/Hacking/roles/john-the-ripper/files/johntheripper1_design.png)

With John the Ripper you provide the encrypted password files. We will combine the passwd file and the shadow file to one single file and direct John the Ripper to that file.

The passwd file store account information while the shadow contains the encrypted passwords.
