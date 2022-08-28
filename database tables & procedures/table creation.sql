create database milestone2

create table users (
username varchar(20),
first_name varchar(20),
last_name varchar(20),
pass varchar(20),
email varchar(50),
primary key(username)
)

create table user_mobile (
username varchar(20),
mobile_number varchar(20),
foreign key(username) REFERENCES users(username) on delete cascade on update cascade ,
primary key(username , mobile_number)
)

create table user_addresses (
username varchar(20),
addresses varchar(100),
foreign key(username) REFERENCES users(username) on delete cascade on update cascade ,
primary key(username , addresses)
)

create table customer (
username varchar(20),
points int,
foreign key(username) REFERENCES users(username) on delete cascade on update cascade ,
primary key(username )
)

create table admins (
username varchar(20),
foreign key(username) REFERENCES users(username) on delete cascade on update cascade ,
primary key(username)
)

create table vendor (
username varchar(20),
activated bit ,
company_name varchar(20),
bank_acc_num varchar(20),
admin_user_name varchar(20),
foreign key(username) REFERENCES users(username)  ,
foreign key(admin_user_name) REFERENCES admins  ,
primary key(username)
)

create table delivery_person (
username varchar(20),
is_activated bit,
foreign key(username) REFERENCES users(username) on delete cascade on update cascade ,
primary key(username)
)

create table credit_card (
number varchar(20),
expiry_date date,
cvv_code varchar(4),
primary key(number)
)

create table delivery (
id int identity,
time_duration int,
fees decimal(5,3),
username varchar(20),
type varchar(20),
foreign key(username) REFERENCES admins(username) on delete cascade on update cascade ,
primary key(id)
)

create table orders (
order_no int ,
order_date date,
total_amount int,
cash_amount decimal(10,2),
credit_amount int,
payment_type varchar(20),
order_status varchar(20),
giftcardcode varchar(10),
remaining_days int,
time_limit int,
customer_name varchar(20),
delivery_id int,
creditcard_number varchar(20),
foreign key(customer_name) REFERENCES customer ,
foreign key(delivery_id) REFERENCES delivery(id)  ,
foreign key(creditcard_number) REFERENCES credit_card(number) ,
foreign key(giftcardcode) REFERENCES giftcard(code),
primary key(order_no)
)

create table product (
serial_no int identity,
product_name varchar(20),
category varchar(20),
product_description varchar(50),
price decimal(10,2),
final_price decimal(10,2),
color varchar(20),
available bit,
rate decimal(10,2),
vendor_username varchar(20),
customer_username varchar(20),
customer_order_id int,
foreign key(customer_username) REFERENCES customer ,
foreign key(vendor_username) REFERENCES vendor ,
foreign key(customer_order_id) REFERENCES orders(order_no) ,
primary key(serial_no)
)

create table customeraddstocartProduct (
serial_no int,
customer_username varchar(20),
foreign key(serial_no) REFERENCES product ,
foreign key(customer_username) REFERENCES customer ,
primary key(serial_no,customer_username)
)

create table todays_deals (
deal_id int identity,
deal_amount int ,
expiry_date datetime,
admin_username varchar(20),
foreign key(admin_username) REFERENCES admins ,
primary key(deal_id)
)

create table Todays_Deals_Product (
deal_id int ,
serial_no int ,
foreign key(deal_id) REFERENCES todays_deals ,
foreign key(serial_no) REFERENCES product ,
primary key(deal_id,serial_no)
)


create table todays_deals_product (
deal_id int ,
serial_no int ,
issue_date varchar(20),
foreign key(deal_id) REFERENCES todays_deals(deal_id) ,
foreign key(serial_no) REFERENCES product(serial_no) ,
primary key(deal_id,serial_no)
)

create table offer (
offer_id int identity,
offer_amount int ,
expiry_date varchar(20),
primary key(offer_id)
)

create table offersonproduct (
offer_id int,
serial_no int ,
foreign key(offer_id) REFERENCES offer(offer_id) ,
foreign key(serial_no) REFERENCES product(serial_no) ,
primary key(offer_id,serial_no)
)

create table customer_question_product (
customer_name varchar(20),
serial_no int ,
question varchar(50),
answer varchar(50),
foreign key(customer_name) REFERENCES customer,
foreign key(serial_no) REFERENCES product(serial_no) ,
primary key(customer_name,serial_no)
)

create table wishlist (
username varchar(20),
name varchar(20),
foreign key(username) REFERENCES customer,
primary key(username,name)
)

create table giftcard (
code varchar(10),
amount int ,
expiry_date varchar(20),
username varchar(20),
foreign key(username) REFERENCES admins,
primary key(code)
)

create table wishlist_product (
username varchar(20),
wish_name varchar(20) ,
serial_no int ,
foreign key(username,wish_name) REFERENCES wishlist(username,name),
foreign key(serial_no) REFERENCES product,
primary key(serial_no,wish_name,username)
)

create table admin_customer_giftcard (
remaining_points decimal , 
code varchar(10) ,
customer_name varchar(20) ,
admin_username varchar(20),
foreign key(admin_username) REFERENCES admins,
foreign key(code) REFERENCES giftcard,
foreign key(customer_name) REFERENCES customer,
primary key(code,customer_name,admin_username)
)

create table admin_delivery_order (
order_no int ,
delivery_username varchar(20) ,
admin_username varchar(20),
delivery_window varchar(50),
foreign key(admin_username) REFERENCES admins,
foreign key(order_no) REFERENCES orders,
foreign key(delivery_username) REFERENCES delivery_person,
primary key(order_no,delivery_username)
)

create table customer_creditcard (
cc_number varchar(20),
customer_name varchar(20) ,
foreign key(cc_number) REFERENCES credit_card,
foreign key(customer_name) REFERENCES customer,
primary key(cc_number,customer_name)
)

