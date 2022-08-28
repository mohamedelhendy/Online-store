create proc customerRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
insert into users(username,first_name,last_name,pass,email)
values(@username,@first_name,@last_name,@password,@email)
insert into customer(username)
values(@username)
go

create proc vendorRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50),
@company_name varchar(20),
@bank_acc_no varchar(20)
AS
insert into users(username,first_name,last_name,pass,email)
values(@username,@first_name,@last_name,@password,@email)
insert into vendor(username,company_name,bank_acc_num)
values(@username,@company_name,@bank_acc_no)
go

create proc userLogin
@username varchar(20),
@password varchar(20)
AS
declare @success bit
declare @type  int
if(exists(select username,pass from users where username= @username and pass= @password))
set @success='1'
else
set @success = '0'
if(exists(select username from customer where username= @username))
set @type = '0'
if(exists(select username from vendor where username= @username))
set @type = '1'
if(exists(select username from admins where username= @username))
set @type = '2'
if(exists(select username from delivery where username= @username))
set @type = '3'
print @success
print @type
go


create proc addMobile
@username varchar(20),
@mobile_number varchar(20)
AS
insert into user_mobile
values(@username,@mobile_number)
go

create proc addAddress
@username varchar(20),
@address varchar(100)
AS
insert into user_addresses
values(@username,@address)
go

create proc showProducts
AS
select*
from product
go

create proc ShowProductsbyPrice
AS
select*
from product
order by final_price
go

create proc searchbyname
@text varchar(20)
AS
select*
from product
where product_name like @text
go

create proc AddQuestion
@question varchar(20),
@customer varchar(20),
@serial int
AS
insert into customer_question_product(customer_name,serial_no,question) 
values(@customer,@serial,@question)
go

create proc addToCart
@customer varchar(20),
@serial int
AS
insert into customeraddstocartproduct
values(@serial,@customer)
go

create proc removefromCart
@customer varchar(20),
@serial int
AS
delete from customeraddstocartproduct
where customer_username =  @customer and serial_no = @serial
go 

create proc createWishlist
@customer varchar(20),
@name varchar(20)
AS
insert into wishlist
values(@customer,@name)
go 

create proc  AddtoWishlist
@customer varchar(20),
@name varchar(20),
@serial_no int
AS
insert into wishlist_product
values(@customer,@name,@serial_no)
go 

create proc removefromWishlist
@customer varchar(20),
@name varchar(20),
@serial_no int
AS
delete from wishlist_product
where username =  @customer and wish_name = @name and serial_no = @serial_no
go 

create proc showWishlistProduct
@customer varchar(20),
@name varchar(20)
AS
select product.*
from  product inner join wishlist_product on wishlist_product.serial_no = product.serial_no
where wishlist_product.username =  @customer and wishlist_product.wish_name = @name
go 

create proc viewMyCart
@customer varchar(20)
AS
select p.*
from customeraddstocartProduct cc inner join product p on p.serial_no = cc.serial_no 
where cc.customer_username =  @customer
go 

create proc calculatepriceOrder
@customer varchar(20)
AS
declare @sum int
select @sum = sum(p.final_price)
from customeraddstocartProduct cc inner join product p on p.serial_no = cc.serial_no 
where cc.customer_username =  @customer
print @sum
go 

create proc productsinorder
@customer varchar(20),
@orderID int
AS
declare @total decimal 
exec  calculatepriceOrder @customer , @total output
select * from orders where orders.customer_name = @customer
insert into orders(customer_name,total_amount,order_no)
values(@customer,@total , @orderID)
update product set available = 0 where product.customer_order_id = @orderID
delete customeraddstocartProduct where serial_no in 
(select serial_no from product where product.customer_order_id = @orderID )
go 

create proc emptyCart
@customer varchar(20)
AS
delete customeraddstocartProduct 
where customer_username =  @customer
go 

create proc makeOrder
@customer varchar(20)
AS
exec productsinorder @customer
insert into orders(order_date,order_status)
values(CURRENT_TIMESTAMP,'not processed')
exec emptyCart @customer
go 

create proc cancelOrder
@orderID int 
AS
declare @todaydate date , @pointused decimal
if (select o.order_status from orders o where o.order_no =  @orderID) = 'not processed' or 
(select o.order_status from orders o where o.order_no =  @orderID) ='in process'
delete orders where orders.order_no =  @orderID
update product set available = 1 where product.customer_order_id = @orderID
if (select total_amount from orders where order_no = @orderID) > (select (cash_amount+credit_amount) from orders where order_no = @orderID)
begin
set @pointused = (select total_amount-(cash_amount+credit_amount) from orders where order_no = @orderID)
select @todaydate =(select convert(date,CURRENT_TIMESTAMP))
if DATEDIFF  (day , (select expiry_date from giftcard where code in (select giftcardcode from orders where order_no =  @orderID ) ), @todaydate) < 0
begin
update customer set points = customer.points + @pointused where customer.username in (select customer_name from orders where order_no =  @orderID)
update admin_customer_giftcard set remaining_points = admin_customer_giftcard.remaining_points + @pointused where admin_customer_giftcard.customer_name in (select customer_name from orders where order_no =  @orderID)
end
end
go 

create proc returnProduct
@serial_no int,
@orderID int
AS
declare @todaydate date , @pointused decimal
update product set available = 1 where product.serial_no = @serial_no
update orders set total_amount = 0 where order_no = @orderID
if (select total_amount from orders where order_no = @orderID) > (select (cash_amount+credit_amount) from orders where order_no = @orderID)
begin
set @pointused = (select total_amount-(cash_amount+credit_amount) from orders where order_no = @orderID)
select @todaydate =(select convert(date,CURRENT_TIMESTAMP))
if DATEDIFF  (day , (select expiry_date from giftcard where code in (select giftcardcode from orders where order_no =  @orderID ) ), @todaydate) < 0
begin
update customer set points = customer.points + @pointused where customer.username in (select customer_name from orders where order_no =  @orderID)
update admin_customer_giftcard set remaining_points = admin_customer_giftcard.remaining_points + @pointused where admin_customer_giftcard.customer_name in (select customer_name from orders where order_no =  @orderID)
end
end
go 

create proc ShowproductsIbought
@customer varchar(20)
AS
select *
from product 
where product.customer_username =  @customer
go 

create proc rate
@customer varchar(20),
@serial_no int,
@rate int
AS
update product set rate = @rate
where product.serial_no =@serial_no and product.customer_username =@customer
go 

create proc SpecifyAmount
@customer varchar(20),
@orderID int, 
@cash decimal(10,2),
@credit decimal(10,2)
AS
declare @sumpaid decimal , @needed_points decimal ,@order_price decimal , @issued_points decimal
update orders set cash_amount = @cash
update orders set credit_amount = @credit
if @cash = null update orders set payment_type = 'credit'
if @credit = null update orders set payment_type = 'cash'
where orders.order_no = @orderID
set @sumpaid = @cash + @credit
set @order_price = ( select orders.total_amount from orders where orders.order_no = @orderID )
set @needed_points = @order_price - @sumpaid 
if @needed_points > 0
begin
set @issued_points = (select acg.remaining_points from admin_customer_giftcard acg where acg.customer_name = @customer)
print 'He is issued Giftcard of ' +@issued_points + ' Points.' 
update orders set giftcardcode = (select acg.code from admin_customer_giftcard acg where order_no = @orderID)
update admin_customer_giftcard set remaining_points = remaining_points - @needed_points where customer_name = @customer
update customer set points = points - @needed_points
end ;
go 

create proc  AddCreditCard
@creditcardnumber varchar(20),
@expirydate date,
@cvv varchar(4),
@username varchar(20)
AS
insert into credit_card
values(@creditcardnumber,@expirydate,@cvv)
insert into customer_creditcard
values(@creditcardnumber,@username)
go

create proc  ChooseCreditCard
@creditcard varchar(20),
@orderID int
AS
update orders set creditcard_number = @creditcard
where orders.order_no = @orderID
go 

create proc  viewDeliveryTypes
AS
select *
from delivery
go 

create proc  specifydeliverytype
@deliveryID int,
@orderID int
AS
update orders set delivery_id =  @deliveryID
update orders set remaining_days = (select time_duration from delivery where delivery.id =  @deliveryID )
where orders.order_no = @orderID
go

create proc  trackRemainingDays
@customername varchar(20),
@orderID int
AS
declare @passed int,@todaydate date , @days int ,@duration int
select @todaydate =(select convert(date,CURRENT_TIMESTAMP))
select @passed = DATEDIFF(day , (select orders.order_date from orders where orders.order_no = @orderID), @todaydate)
set @duration =(select delivery.time_duration from delivery where delivery.id in
(select orders.delivery_id from orders where orders.order_no = @orderID) )
update orders set remaining_days = @duration - @passed where orders.order_no = @orderID
set @days =(select orders.remaining_days from orders where orders.order_no = @orderID)
print @days
go 

create proc  recommmend
@customername varchar(20)
AS
declare @cat varchar(20),@commuser varchar(20)
set @cat = (select category from product where serial_no in (select serial_no from customeraddstocartProduct where customer_username = @customername))
set @commuser =(select customer_username from customeraddstocartProduct where serial_no in (select serial_no from customeraddstocartProduct where customer_username = @customername))
select distinct product.product_name from product where category = @cat and serial_no in (select serial_no from wishlist_product)
union 
select distinct product.product_name from product where serial_no in (select serial_no from wishlist_product where username = @commuser)
go


CREATE PROC postProduct
@vendorUsername VARCHAR(20) ,
@product_name VARCHAR(20) ,
@category VARCHAR(20) ,
@product_description text ,
@price decimal(10,2 ) ,
@color VARCHAR(20)
AS
INSERT INTO product (product_name,category,product_description,price,color,vendor_username)
VALUES(@product_name,@category,@product_description,@price,@color,@vendorUsername)
GO

CREATE PROC vendorviewProducts
@vendorname VARCHAR(20)
AS
select * from product
where product.vendor_username=@vendorname 
GO

CREATE PROC EditProduct
@vendorname VARCHAR(20) ,
@serialnumber INT ,
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description text ,
@price decimal (10,2) ,
@color VARCHAR (20)
AS
UPDATE product
SET product_name=@product_name,category=@category,product_description=@product_description,price=@price,color=@color 
WHERE vendor_username=@vendorname and serial_no=@serialnumber
GO

CREATE PROC deleteProduct
@vendorname VARCHAR(20) , @serialnumber int 
AS
DELETE FROM product where product.vendor_username = @vendorname AND product.serial_no = @serialnumber
go

CREATE PROC viewQuestions 
@vendorname VARCHAR(20) 
AS
select Q.* from customer_question_product Q INNER JOIN product P ON Q.serial_no =p.serial_no
WHERE p.vendor_username = @vendorname 
GO

CREATE PROC answerQuestions 
@vendorname VARCHAR(20) ,
@serialno int ,
@customername VARCHAR(20) ,
@answer text 
AS 
UPDATE customer_question_product SET answer = @answer 
WHERE customer_question_product.customer_name=@customername AND customer_question_product.serial_no=@serialno 
go

create proc  addOffer
@offer_amount int,
@expiry_date datetime
AS
insert into offer values(@offer_amount,@expiry_date)
go

create proc  applyOffer
@vendor_username varchar(20),
@offer_id int,
@serial_no int
AS
declare @amount decimal
set @amount = (select offer_amount from offer where offer_id = @offer_id)
if ((select final_price from product where serial_no = @serial_no) = (select price from product where serial_no = @serial_no)) and DATEDIFF  (day , (select expiry_date from offer where offer_id = @offer_id ), CURRENT_TIMESTAMP) < 0
begin
update product set final_price = price - @amount
insert into offersonproduct values(@offer_id,@serial_no)
end
else
begin 
print'the product has an active offer'
end
go

create proc  checkOfferonProduct
@serial_no int
AS
declare @out bit
if (exists (select offer_id from offersonproduct where serial_no = @serial_no)) set @out = 1 else set @out = 0
print @out
go

create proc  checkandremoveExpiredoffer
@offer_id int
AS
if DATEDIFF  (day , (select expiry_date from offer where offer_id = @offer_id ), CURRENT_TIMESTAMP) > 0 
delete offer where offer_id = @offer_id
go



create proc  activateVendors
@admin_username varchar(20),
@vendor_username varchar(20)
AS
update vendor set admin_user_name = @admin_username
update vendor set activated = 1
where vendor.username = @vendor_username
go

create proc  inviteDeliveryPerson
@delivery_username varchar(20),
@delivery_email varchar(20)
AS
insert into users (username,email)values(@delivery_username,@delivery_email)
insert into delivery_person(is_activated,username)values(0,@delivery_username)
go

create proc  reviewOrders
AS
select * from orders
go

create proc  updateOrderStatusInProcess
@order_no int
AS
update orders set order_status = 'in process'
go

create proc  addDelivery
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
AS
insert into delivery values(@time_duration,@fees,@admin_username,@delivery_type)
go

create proc  assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
insert into admin_delivery_order(delivery_username,order_no,admin_username) values(@delivery_username,@order_no,@admin_username)
go

create proc  createTodaysDeal
@deal_amount int,
@admin_username varchar(20),
@expiry_date datetime
AS
insert into todays_deals values(@deal_amount,@expiry_date,@admin_username)
go

create proc  addTodaysDealOnProduct
@deal_id int,
@serial_no int
AS
insert into Todays_Deals_Product values(@deal_id,@serial_no)
go

create proc  checkTodaysDealOnProduct
@serial_no int
AS
declare @out bit
if (exists (select deal_id from Todays_Deals_Product where serial_no = @serial_no)) set @out = 1 else set @out = 0
print @out
go

create proc  removeExpiredDeal
@deal_id int
AS
if DATEDIFF  (day , (select expiry_date from todays_deals where deal_id = @deal_id ), CURRENT_TIMESTAMP) > 0 
delete todays_deals where deal_id = @deal_id
go

create proc  createGiftCard
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20)
AS
insert into giftcard values(@code,@amount,@expiry_date,@admin_username)
go

create proc  giveGiftCardtoCustomer
@code varchar(10),
@cutomer_name varchar(20),
@admin_username varchar(20)
AS
declare @amount decimal
set @amount = (select amount from giftcard where code = @code)
insert into admin_customer_giftcard values(@amount,@code,@cutomer_name,@admin_username)
update customer set points =points + @amount
go

create proc  removeExpiredGiftCard
@code varchar(10)
AS
declare @amount decimal
if DATEDIFF  (day , (select expiry_date from giftcard where code = @code ), CURRENT_TIMESTAMP) > 0 
set @amount = (select amount from giftcard where code = @code )
delete giftcard where code = @code
delete admin_customer_giftcard where code = @code
update customer set points =points- @amount
go

create proc  checkGiftCardOnCustomer
@code varchar(10)
AS
declare @out bit
if (exists (select * from admin_customer_giftcard where code = @code)) set @out = 1 else set @out = 0
print @out
go


create proc acceptAdminInvitation
@delivery_username varchar(20)
AS
update delivery_person  set is_activated = 1 
where delivery_person.username = @delivery_username
go

create proc deliveryPersonUpdateInfo
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
select* from users where users.username = @username
insert into users(first_name,last_name,pass,email)
values(@first_name,@last_name,@password,@email)
go

create proc viewmyorders
@username varchar(20)
AS
select*
from orders inner join delivery on delivery.id = orders.delivery_id
where delivery.username = @username
go

create proc specifyDeliveryWindow
@delivery_username varchar(20),
@orderID int,
@delivery_window varchar(50)
AS
update admin_delivery_order set delivery_window =  @delivery_window
where order_no = @orderID
go

create proc  updateOrderStatusOutforDelivery
@orderID int
AS
update orders set order_status =  'out for delivery'
where orders.order_no = @orderID
go

create proc  updateOrderStatusDelivered
@orderID int
AS
update orders set order_status =  'delivered'
where orders.order_no = @orderID
go