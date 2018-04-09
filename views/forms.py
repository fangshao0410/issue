from wtforms import Form,widgets,validators
from wtforms.fields import simple

class MyForms(Form):
    name=simple.StringField(
        label='用户名',
        validators=[
            validators.DataRequired(message='用户名不能为空'),
        ],
        widget=widgets.TextInput(),
        render_kw={'class':'form-control'}
    )
    password=simple.PasswordField(
        label='密码',
        validators=[
            validators.DataRequired(message='密码不能为空'),
        ],
        widget=widgets.PasswordInput(),
        render_kw={'class':'form-control'}
    )