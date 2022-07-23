
--Creating a view so it can be queried off on to reduce the complexity of the queries
create view top_winners
as 
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
		events_base.region = medal_base.region;
		
		
--Calculating the winning percentage for the top 50 countries with the highest number of events participated in 

SELECT *,
	round(((Num_medals_won*1.0)/Num_events_participated)*100,2) as Winning_percentage

from 
	top_winners
	
order by Num_events_participated DESC
LIMIT  50;


--Ranking the top 50 regions in terms of the number of events participated in 
-- In order for the winning percentage to be calculated, the division has to be carried out as a float rather than an INTEGER
-- That is the reason why the Num_medals_won column is being multiplied by 1.0 to force a float calculation

select *,
	rank() OVER(order by Winning_percentage DESC) as rank_no
	
from 	
	(
		SELECT *,
			round(((Num_medals_won*1.0)/Num_events_participated)*100,2) as Winning_percentage

		from 
			top_winners
			
		order by Num_events_participated DESC
		LIMIT  50) as winning_percentage_base
		
		
--counting the number of medals won for the persons persons with games participation 

select 
	id,
	count(winner_id) as Num_medals 
from
	demographics left join medal_winners
on 
	demographics.ID = medal_winners.winner_id
group by 
	id
order by 
	Num_medals desc

-- counting the number of events each participants has participated in 

select 
	player_id, 
	count(player_id) as Num_events
from 
	Events_participated
group by
	player_id
order by
	Num_events desc
	
--Computing the number of events participated in and the number of medals won by each participant
--Creating a view to query off to calculate the winning percentage for the players
Create view top_player_winners
as
select player_id as Participant_id,
		Num_events,
		Num_medals
from 
	(select 
		player_id, 
		count(player_id) as Num_events
	from 
		Events_participated
	group by
		player_id
	order by
		Num_events desc	) as events_counter 
inner join 
	(select 
		id,
		count(winner_id) as Num_medals 
	from
		demographics left join medal_winners
	on 
		demographics.ID = medal_winners.winner_id
	group by 
		id
	order by 
		Num_medals desc	) as medals_counter	
on events_counter.player_id = medals_counter.id	;	

--Computing the winning percentage for the participants


select Participant_id, 
	Num_events,
	Num_medals,
	round(((Num_medals*1.0)/Num_events)*100,2) as Winning_percentage
	
From top_player_winners
order by Num_events desc	

-- Ranking the players by their winning percentage
select *,
	rank() over(ORDER by winning_percentage desc) as rank_no
from
	 (select Participant_id, 
		Num_events,
		Num_medals,
		round(((Num_medals*1.0)/Num_events)*100,2) as Winning_percentage
		
	From top_player_winners
	order by Num_events desc) as percent_win_base
	
where Num_events > 15	

