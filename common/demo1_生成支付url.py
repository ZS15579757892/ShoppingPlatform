from alipay import AliPay

# 1.支付宝环境准备 沙箱环境
# 应用id
app_id = '9021000133635935'
# 商户号
pid = '2088721025873315'
# 公钥和私钥
public_key = open('common/alipay_public_key.pem').read()
private_key = open('common/alipay_private_key.pem').read()

# 2.订单支付的信息
# 订单号
order_on = '20231223000090001'
# 订单金额
amount = '1999.00'
# 支付页面的标题
subject = '生鲜订单{}支付'.format(order_on)

# 3.初始化一个支付对象
pay = AliPay(appid=app_id,
             app_notify_url=None,
             app_private_key_string=private_key,
             alipay_public_key_string=public_key,
             debug=True,)

# 4.生成手机应用的支付地址
# url = pay.api_alipay_trade_wap_pay(
#     subject=subject,
#     out_trade_no=order_on,
#     total_amount=amount,
#     return_url=None,
#     notify_url=None)

# 生成pc浏览器网站的支付页面地址
url = pay.api_alipay_trade_page_pay(
    subject=subject,
    out_trade_no=order_on,
    total_amount=amount,
    return_url=None,
    notify_url=None
)

pay_url = 'https://openapi-sandbox.dl.alipaydev.com/gateway.do?' + url
print(pay_url)
