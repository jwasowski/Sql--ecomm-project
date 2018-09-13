1. Podwojny J_oin podajacy cene zakupu oraz sprzedazy poszczegolnych przedmiotow:

select p.id_products as "ID",p.product_name as "Nazwa Produktu",
product_units.id_product_units as "ID jednostki kupna", product_units.acquisition_net_total_price as "Cena kupna netto",
ifi.id_product_units as "ID jednostki sprzedazy", ifi.sale_net_price as "Cena sprzedazy netto"
from products p
left join product_units
on (product_units.acquisition_net_total_price and product_units.id_product_units=p.id_products)
left join invoice_fields ifi
on (ifi.sale_net_price and ifi.id_product_units=p.id_products );

2.Zapytania agregujace:

select sum(distinct net_price),sum(distinct gross_price) from products;

Suma cen sprzedazowych produktow (netto oraz brutto rozdzielnie).

select count(product_name) from products where net_price>300;

Zwraca ilosc produktow, ktorych cena netto przekracza 300 jednostek.

select id_client as "ID klienta",name,surname from clients where client_type!="firma";

Zwraca numer ID, imie, nazwisko klienta, ktory nie jest firma.

select count(id_workers) as "Ilosc wystawionych faktur",id_workers as "ID pracownika" from invoices group by id_workers;

Zwraca ilosc wystawionych faktur przez pracownika.

select name,surname from workers where id_workers in(1,2,3);

Zwroci imie i nazwisko pracownikow o id 1,2 oraz 3.

select count(i.id_workers) as "Ilosc wystawionych faktur",i.id_workers as "ID pracownika",
workers.id_workers,workers.name,workers.surname from invoices i 
left join workers on workers.id_workers=i.id_workers group by i.id_workers;

Zwraca jako gotowy zestaw informacje kto wystawil ile faktur poczynajac od najwiekszej ilosc wystawionych faktur.

select pu.id_products as "ID produktow",count(pu.id_products) as "Ilosc produktow",
products.product_name as "Nazwa produktow" from product_units pu 
right join products on
(products.id_products<=>pu.id_products and pu.is_sold<=>1 ) group by pu.id_products;

Wyswietla ilosc wszystkich produktow jakie zosta³y sprzedane.

select pu.id_products as "ID produktow",count(pu.id_products) as "Ilosc produktow",
products.product_name as "Nazwa produktow" from product_units pu 
right join products on
(products.id_products<=>pu.id_products and pu.is_sold<=>0 ) group by pu.id_products;

Wyswietla aktualny stan produktow (pojawia sie dziwna anomalia z pierwszym rekordem).

3. I_nsert:

insert into products values (0,3,"Seagate Barracuda HDD 5400 500 GB","HDD Sata3",120,120+120*0.23,23);

Tworzy nowy produkt jako wpis do tabeli products (brak implementacji dodawania produktow wraz z dodaniem konrektnych produktow do product_units)

4. U_pdate:

update products set net_price=130, gross_price=130+130*0.23 ORDER BY id_products DESC limit 1;

Aktualizacja ceny produktu dodanego w ostatnim i_nsert'cie.

5. Delete:

delete from products order by id_products DESC limit 1;

Usuwa wpis dodany insertem.