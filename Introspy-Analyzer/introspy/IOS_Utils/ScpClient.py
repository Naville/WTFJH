import subprocess
from sys import exit
from os.path import basename, isfile


class ScpClient:
    """
    Identifies and securely copies an introspy database from a device to
    the localhost for analysis.
    """

    def __init__(self, ip=None, user="root", port=None):
        self.cnx_str = "%s@%s" % (user, ip)
        self.port    = port

    def select_db(self):
        cmd = "ssh %s find /var/mobile/Containers/Data -iname 'wtfjh-*.db'" % self.cnx_str
        if self.port != None:
            cmd = cmd[:4] + ("-p %s " % self.port) + cmd[4:]

        proc = subprocess.Popen(cmd.split(),
            stdout=subprocess.PIPE,
    	    stderr=subprocess.PIPE)
        dbs, err = proc.communicate()
        # something went wrong
        # Can't rely on what's in err as you can get stuff in stderr even with a successful transfer
        # For example "Saving password to keychain failed" on OS X
        if len(dbs) is 0:
            print "Couldn't find any introspy databases."
            exit(0)
        # remove local and parent directory entries
        dbs = dbs.split()
        # let the user choose which db to grab
        for num, db in enumerate(dbs):
            print "%s. %s" % (num, db)
        choice = int(raw_input("Select the database to analyze: "))
        return dbs[choice]

    def select_and_fetch_db(self):
        remote_db_path = self.select_db()
        cmd = "scp %s:%s ./" % (self.cnx_str, remote_db_path)
        if self.port != None:
            cmd = cmd[:4] + ("-P %s " % self.port) + cmd[4:]

        proc = subprocess.Popen(cmd.split(),
     	    stdout=subprocess.PIPE,
      	    stderr=subprocess.PIPE)
        out, err = proc.communicate()

        # something went wrong
        if not isfile(basename(remote_db_path)):
            print "Error copying file from remote device."
            exit(0)
        return basename(remote_db_path)

    def delete_remote_dbs(self):
        cmd = "ssh %s find . -iname 'introspy-*.db' -print | xargs rm" % self.cnx_str
        if self.port != None:
            cmd = cmd[:4] + ("-p %s " % self.port) + cmd[4:]

        proc = subprocess.Popen(cmd.split(),
            stdout=subprocess.PIPE,
    	    stderr=subprocess.PIPE)
        dbs, err = proc.communicate()
        # something went wrong
        # err may contain data although the delete was successful
        #if err:
        #    print "Error removing introspy dbs."
        #    exit(0)
        print "Removed all introspy dbs."

