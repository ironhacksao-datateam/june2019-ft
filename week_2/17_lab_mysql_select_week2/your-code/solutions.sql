/* Challenge 1*/

create table challenge1
SELECT authors.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, titles.title AS TITLE, publishers.pub_name AS PUBLISHER
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;


/* Challenge 2*/
create table counts
SELECT AUTHOR_ID, LAST_NAME, FIRST_NAME, PUBLISHER, COUNT(*) as TITLE_COUNT FROM challenge1 GROUP BY AUTHOR_ID, PUBLISHER;


/* Challenge 3

sales: titleID, qty
titleauthor: titleID, au_id -> sum
author: au_id, lastname, firstname, 
*/

select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as total
from authors a
inner join titleauthor ta on a.au_id = ta.au_id
inner join sales s on ta.title_id = s.title_id
group by a.au_id
order by total desc
limit 3;



/* Challenge 4
there will be titles in titleauthor that don't have any sales =>
left join to include them
The sum will place a null in these cells. 
Use coalesce to display 0 instead of null, 
 */

select a.au_id, a.au_lname, a.au_fname, coalesce(sum(s.qty),0) as total
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join sales s on ta.title_id = s.title_id
group by a.au_id
order by total desc;




/* Bonus challenge

author id
last name
first name
profit - top 3 (advance + royalties) - royaltyper 


total profit = advance + royalties
advance = advance*royaltyper/100
royalties = price*qty*royalty*royaltyper/100

authors: au_lname, au_fname, au_id
titleauthor: au_id, royaltyper, title_id
titles: title_id, price, advance, royalty
sales: title_id, qty 
*/

select 	au_id as authorID, au_lname as lastName, au_fname as firstName, 
		sum(advance + royalties) as profits 
from (
	select title_id, au_id, au_lname, au_fname, advance, sum(royalties) as royalties 
	from (
		select t.title_id, t.price, (t.advance*royaltyper/100) as advance, t.royalty, s.qty, a.au_id, au_lname, au_fname, 
        ta.royaltyper, (t.price * s.qty * t.royalty/100 * ta.royaltyper / 100) as royalties
		from titles t
		inner join sales s on s.title_id = t.title_id
		inner join titleauthor ta on ta.title_id = s.title_id
		inner join authors a on a.au_id = ta.au_id
	) as tmp
	group by au_id, title_id
) as tmp2
group by au_id
order by profits desc
limit 3;
