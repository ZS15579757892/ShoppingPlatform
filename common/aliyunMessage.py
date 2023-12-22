"""
签名名称: 阿里云短信测试
使用场景: 发送测试短信
模版名称: 测试专用模板
模版Code: SMS_154950909
模版类型: 验证码
模版内容: 您正在使用阿里云短信测试服务，体验验证码是：${code}，如非本人操作，请忽略本短信！
"""

import json

from alibabacloud_dysmsapi20170525.client import Client
from alibabacloud_tea_openapi.models import Config
from alibabacloud_dysmsapi20170525.models import SendSmsRequest
from alibabacloud_tea_util.models import RuntimeOptions


class AliyunSMS:
    access_key_id = 'access_key_id'
    access_key_secret = 'access_key_secret'
    endpoint = f'dysmsapi.aliyuncs.com'
    sign_name = '阿里云短信测试'
    template_code = 'SMS_154950909'

    def __init__(self):
        self.config = Config(
            access_key_id=self.access_key_id,
            access_key_secret=self.access_key_secret,
            endpoint=f'dysmsapi.aliyuncs.com',
        )

    def send(self, mobile: str, code: str):
        """ code :验证码 """
        # 2.创建一个客户端
        client = Client(self.config)
        # 3.创建短信对象
        send_sms_request = SendSmsRequest(
            sign_name=self.sign_name,
            template_code=self.template_code,
            phone_numbers=mobile,
            template_param=json.dumps({'code': code})
        )
        # 4.设置允许时间选项
        runtime = RuntimeOptions()
        # 5.发送短信
        try:
            res = client.send_sms_with_options(send_sms_request, runtime)
            if res.body.code == 'OK':
                return {'code': 'OK', 'message': '短信发送成功'}
            else:
                return {'code': 'NO', 'message': res.body.message}
        except Exception as e:
            return {'code': 'NO', 'error': '短信发送失败'}


if __name__ == '__main__':
    AliyunSMS().send(mobile='15579757892', code='12123')


# class Sample:
#
#     @staticmethod
#     def create_client(access_key_id: str, access_key_secret: str, ):
#         config = Config.Config(
#             # 必填，您的 AccessKey ID,
#             access_key_id=access_key_id,
#             # 必填，您的 AccessKey Secret,
#             access_key_secret=access_key_secret,
#             endpoint=f'dysmsapi.aliyuncs.com',
#         )
#         # 2.创建一个客户端
#         client = Client(config)
#         # 3.创建短信对象
#         send_sms_request = SendSmsRequest(
#             sign_name='阿里云短信测试',
#             template_code='SMS_154950909',
#             phone_numbers='15579757892',
#             template_param='{"code":"121234"}'
#         )
#         # 4.设置允许时间选项
#         runtime = RuntimeOptions()
#         client.send_sms_with_options(send_sms_request, runtime)
