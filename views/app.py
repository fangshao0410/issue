from . import app
from . import sql
from flask import render_template,request,session
from sqlalchemy.orm import  sessionmaker
from sqlalchemy import create_engine
from .forms import MyForms

app.secret_key='fang'


def msql():
    engine=create_engine('mysql+pymysql://root:0410@127.0.0.1:3306/issue?charset=utf8')
    Session=sessionmaker(bind=engine)
    session=Session()
    return session


@app.route('/login',methods=['GET','POST'])
def login():
    if request.method=='POST':
        form = MyForms(formdata=request.form)
        if form.validate():
            user=request.form.get('name')
            pwd=request.form.get('password')
            mysession = msql()
            users = mysession.query(sql.User).filter_by(name=user, pwd=pwd).first()
            if users:
                session['user_info']={'id':users.id,'name':users.name}
                return 'OK'
            else:
                return render_template('login.html', form=form, msg='用户名或密码错误')
        return render_template('login.html',form=form)



    form = MyForms()
    return render_template('login.html',form=form)

@app.route('/index')
def index():
    mysession=msql()
    release_list=mysession.query(sql.Release).all()

    return render_template('index.html',release_list=release_list)