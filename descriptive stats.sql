--Demographic statistics about the data
--



--Characteristics of the competitors at the first games grouped by the country they represent
select 
		Region as Region,
		round(avg(age_at_first_games),2 )As Average_age,
		max(height) as Tallest ,
		min (height) as Shortest ,
		max(weight) as Heaviest,
		min(weight)as Lightest
from demographics
where age_at_first_games!= 0 and Height!=0 and weight!= 0
group by  region;



-- Initial Hypothesis on the Number of participations being related to the likelihoood of winning a medal
-- The Events_participated is linked with the medal_winners table and a count of the player id is computed as the number of different events 
-- a competitor has participated in.
-- Since a left join was used to link the two tables, for participants who have no winner_id did not win at any of the games.
-- so a conditional is set up for when the winner_id is Null as being 0 and 1 as having won at a particular time  
select 
		DISTINCT player_id,
		count (player_id)as Num_of_events,
		max (case when winner_id is Null then 0 else 1 END) as award_winner


from 
		Events_participated 
left join 
		(select DISTINCT winner_id from medal_winners) as medal_base
on
		Events_participated.player_id = medal_base.winner_id
group by 
		player_id
order by
		count (player_id) DESC;


-- Grouping the winners by the countries

select 
	Region as Region,
	count(*) as Num_medals_won
from
	medal_winners
inner join
	demographics
on 
	medal_winners.winner_id = demographics.ID
group by
	region
order by
	Num_medals_won DESC;
	
--Counting the number of events participated in by each country since the start of the data collection
select 
		Region as Region,
		count(*) as Num_events_participated
from 
		Events_participated left join demographics
on 
		Events_participated.player_id = demographics.id
group by 
		region 
order by 
		Num_events_participated DESC


-- Initial Hypothesis of the countries with a higher number of participating in the events having a much higher number of medals won
-- Query combines two queries on the region. First query is to count the number of events each country has participated in and the second counts 
-- the number of medals won by each country since the start of the data collection
select 
		events_base.region as Region,
		Num_events_participated,
		Num_medals_won
from
	(
		select
				Region as Region,
				count(*) as Num_events_participated
		from 
				Events_participated left join demographics
		on 
				Events_participated.player_id = demographics.id
		group by 
				region 
		order by 
				Num_events_participated DESC) as events_base
inner join 
	(
		select
				Region as Region,
				count(*) as Num_medals_won
		from
				medal_winners inner join demographics
		on 
				medal_winners.winner_id = demographics.ID
		group by
				region
		order by
				Num_medals_won DESC) as medal_base 
on 
		events_base.region = medal_base.region