import shutil
import os


class HTMLReportGenerator:
    """
    Generates an HTML report given an analyzed Introspy DB.
    """

    TRACED_CALLS_FILE_NAME =  'tracedCalls.js'
    FINDINGS_FILE_NAME =      'findings.js'
    API_GROUPS_FILE_NAME =    'apiGroups.js'

    # TODO: merge the two templates and get rid of this
    HTML_TEMPLATE_PATH = os.path.join(os.path.dirname(__file__), 'html')
    ANDROID_TEMPLATE = 'report-android.html'
    IOS_TEMPLATE = 'report-ios.html'
    FINAL_TEMPLATE = 'report.html'


    def __init__(self, analyzedDB, androidDb):
        self.analyzedDB = analyzedDB
        self.androidDb = androidDb


    def write_report_to_directory(self, outDir):

        # Copy the HTML template
        shutil.copytree(os.path.abspath(self.HTML_TEMPLATE_PATH), outDir)


        if self.androidDb:
            shutil.move(os.path.join(outDir, self.ANDROID_TEMPLATE),
                        os.path.join(outDir, self.FINAL_TEMPLATE))
            # Remove the wrong template file
            os.remove(os.path.join(outDir, self.IOS_TEMPLATE))
        else:
            shutil.move(os.path.join(outDir, self.IOS_TEMPLATE),
                        os.path.join(outDir, self.FINAL_TEMPLATE))
            # Remove the wrong template file
            os.remove(os.path.join(outDir, self.ANDROID_TEMPLATE))


        # Copy the DB file
        shutil.copy(self.analyzedDB.dbPath, outDir)

        # Dump the traced calls
        with open(os.path.join(outDir, self.TRACED_CALLS_FILE_NAME), 'w') as jsFile:
            jsFile.write('var tracedCalls = ' + self.analyzedDB.get_traced_calls_as_JSON() + ';')

        # Dump the findings
        with open(os.path.join(outDir, self.FINDINGS_FILE_NAME), 'w') as jsFile:
            jsFile.write( 'var findings = ' + self.analyzedDB.get_findings_as_JSON() + ';')

        # Dump the API groups
        with open(os.path.join(outDir, self.API_GROUPS_FILE_NAME), 'w') as jsFile:
            jsFile.write('var apiGroups = ' + self.analyzedDB.get_API_groups_as_JSON() + ';')

