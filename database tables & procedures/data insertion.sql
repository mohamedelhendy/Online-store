insert into users 
values('hana.aly', 'hana' ,'aly' ,'pass1' ,'hana.aly@guc.edu.eg'),
('ammar.yasser', 'ammar' ,'yasser' ,'pass4' ,'ammar.yasser@guc.edu.eg'),
('nada.sharaf', 'nada' ,'sharaf' ,'pass7' ,'nada.sharaf@guc.edu.eg'),
('hadeel.adel', 'hadeel' ,'adel' ,'pass13' ,'hadeel.adel@guc.edu.eg'), 
('mohamed.tamer', 'mohamed' ,'tamer' ,'pass16' ,'mohamed.tamer@guc.edu.eg')     
    
insert into admins  
values('hana.aly'),
('nada.sharaf')

insert into customer
values('ammar.yasser',15)

insert into customeraddstocartProduct
values(1,'ammar.yasser')

insert into vendor
values('hadeel.adel', 1, 'Dello' ,'47449349234', 'hana.aly')

insert into delivery_person
values('mohamed.tamer',1)

insert into user_addresses
values('hana.aly','New Cairo'),
('hana.aly','Heliopolis')

insert into user_mobile
values('hana.aly','01111111111'),
('hana.aly','1211555411')

insert into credit_card
values('4444-5555-6666-8888','2028-10-19',232)

insert into delivery(type,time_duration,fees)
values('pick-up',7,10),
('regular',14,30),
('speedy',1,50)

insert into product(product_name,category,product_description,price,final_price,color,
available, rate, vendor_username)
values('Bag' ,'Fashion', 'backbag', 100, 100 ,'yellow', 1, 0 ,'hadeel.adel'),
('Blue pen', 'stationary', 'useful pen', 10, 10, 'Blue', 1, 0 ,'hadeel.adel'),
('Blue pen', 'stationary', 'useful pen', 10, 10, 'Blue', 0, 0 ,'hadeel.adel')

insert into todays_deals
values(30 , '2019-11-30' ,'hana.aly'),
(40 , '2019-11-18' ,'hana.aly'),
(50 , '2019-12-12' ,'hana.aly'),
(10 , '2019-11-12' ,'hana.aly')

insert into offer
values(1,50,30/11/2019)

insert into wishlist
values( 'ammar.yasser' ,'fashion')

insert into wishlist_product
values('ammar.yasser','fashion',2),
('ammar.yasser','fashion',4)

insert into giftcard(code, expiry_date, amount)
values('G101' ,'18/11/2019' ,100)














