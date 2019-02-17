
# A very simple Bottle Hello World app for you to get started with...
from bottle import default_app, route, static_file, request, hook
import bottle_mysql
import impl

STATIC_HTML_DIR='/home/snivas/jobconsultant/public/'

@hook('before_request')
def strip_path():
    request.environ['PATH_INFO'] = request.environ['PATH_INFO'].rstrip('/')

@route('/')
def root():
    return {'msg': 'Job Consultant Service'}

@route('/echo')
def echo(db):
    return "Test"

#To serve HTMl Pages
@route('/ui/<filepath:path>', method=['GET'])
def server_static(filepath):
    return static_file(filepath, root= STATIC_HTML_DIR)

#JOBs API
@route('/jobs', method=['GET','POST'])
def fetch_jobs(db):
    status = request.query.status or 'all'
    query = request.query.q or ''
    return impl.query_jobs(db, status, query);

#Shortlisted API
@route('/jobs/<jobid>/shortlisted', method=['GET'])
def fetch_shortlisted(db, jobid):
    return impl.query_shortlisted(db, jobid);

#Interviews API
@route('/jobs/<jobid>/interviews/<candid>', method=['GET'])
def fetch_interviews(db, jobid, candid):
    return impl.query_interviews(db, jobid, candid);

application = default_app()
plugin = bottle_mysql.Plugin(dbhost='xxxxxxxxx',
                             dbuser='xxxx',
                             dbpass='xxxx',
                             dbname='xxxx')
application.install(plugin)
