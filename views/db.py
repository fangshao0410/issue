from views import app,sql
from flask_script import Manager
from flask_migrate import Migrate,MigrateCommand

manager=Manager(app)
migrate=Migrate(app,sql)
manager.add_command('sql',MigrateCommand)

@manager.command
def custom(arg):
    '''
    自定义命令
    python manage.py custom 123
    :param arg:
    :return:
    '''
    print(arg)

@manager.option('-n','--name',dest='name')
@manager.option('-u','--url',dest='url')
def cmd(name,url):
    '''
    执行自定义命令：python manage.py  cmd -n wupeiqi -u http://www.oldboyedu.com
    :param name:
    :param url:
    :return:
    '''
    print(name,url)



if __name__ == '__main__':
    manager.run()
