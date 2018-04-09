from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import String,ForeignKey,DateTime,Column,Integer,Date,Text,Enum
from sqlalchemy.orm import relationship
from sqlalchemy_utils.types.choice import ChoiceType
from sqlalchemy import create_engine

Base=declarative_base()

class User(Base):
    '''
    用户表
    '''
    __tablename__='user'
    id = Column(Integer, primary_key=True, index=True, nullable=False)
    name=Column(String(32),index=True,nullable=False)
    pwd=Column(String(32),index=True,nullable=False)
    department_id=Column(Integer,ForeignKey('department.id'),nullable=False)
    rdatetime=Column(DateTime(),index=True,nullable=False)

    department = relationship('Department', backref='user')
    release = relationship('Release', backref='user')


class Department(Base):
    '''
    部门表
    '''
    __tablename__ = 'department'
    id = Column(Integer, primary_key=True, index=True, nullable=False)
    name=Column(String(32),index=True,nullable=False)
    code_number=Column(Integer,index=True,nullable=False)
    edate=Column(Date(),index=True,nullable=False)


class Hosts(Base):
    '''
    主机表
    '''
    __tablename__ = 'hosts'
    id = Column(Integer, primary_key=True, index=True, nullable=False)
    hoatname=Column(String(32),index=True,nullable=False)
    ip=Column(String(32),index=True,nullable=False)
    port=Column(Integer,index=True,nullable=False)
    project_id=Column(Integer,ForeignKey('project.id'),index=True,nullable=False)

    project = relationship('Project', backref='hosts')

class Project(Base):
    '''
    项目表
    '''
    __tablename__='project'
    id = Column(Integer, primary_key=True, index=True, nullable=False)
    name=Column(String(120),index=True,nullable=False)
    git_addr=Column(String(120),index=True,nullable=False)
    online_path=Column(String(120),index=True,nullable=False)
    introduce=Column(Text,index=True,nullable=False)
    edatetime=Column(DateTime(),index=True,nullable=False)
    department_id=Column(Integer,ForeignKey('department.id'),index=True,nullable=False)

    department=relationship('Department',backref='project')


class Release(Base):
    '''
    发布表
    '''
    __tablename__='release'
    id = Column(Integer, primary_key=True, index=True, nullable=False)
    user_id=Column(Integer,ForeignKey('user.id'))
    project_id=Column(Integer,ForeignKey('project.id'),index=True,nullable=False)
    types=Column(ChoiceType([('1','发布'),('2','回滚')]),index=True,nullable=False)
    status=Column(ChoiceType([('1','已发布'),('2','未发布')]),index=True,nullable=False)

    project=relationship('Project',backref='release')

class ReleaseLog(Base):
    '''
    发布日志表
    '''
    __tablename__='releaselog'
    id=Column(Integer,primary_key=True,index=True,nullable=False)
    logdatetime=Column(DateTime(),index=True,nullable=False)
    release_id=Column(Integer,ForeignKey('release.id'),index=True,nullable=False)

    release=relationship('Release',backref='releaselog' )

def init_db():
    '''
    创建数据库的表
    :return:
    '''
    engine=create_engine(
        'mysql+pymysql://root:0410@127.0.0.1:3306/issue?charset=utf8',
        max_overflow=0,
        pool_size=8,
        pool_timeout=30,
        pool_recycle=-1
    )

    Base.metadata.create_all(engine)


def drop_db():
    """
    根据类删除数据库表
    :return:
    """
    engine = create_engine(
        'mysql+pymysql://root:0410@127.0.0.1:3306/issue?charset=utf8',
        max_overflow=0,  # 超过连接池大小外最多创建的连接
        pool_size=5,  # 连接池大小
        pool_timeout=30,  # 池中没有线程最多等待的时间，否则报错
        pool_recycle=-1  # 多久之后对线程池中的线程进行一次连接的回收（重置）
    )

    Base.metadata.drop_all(engine)
