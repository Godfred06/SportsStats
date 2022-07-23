
-- Table displaying the demographics data of the participants in the Games from the time data was being collected

Create table if not exists demographics
as

select  id,
			Name,
			sex,
			athlete_events.NOC as NOC,
			max(region) as region,
			(cast(max(Height) as int)) as Height,
			(cast(max(Weight) as int)) as Weight,
			max(team) as Team,
			(cast(min(age) as int))as age_at_first_games,
			(cast(max(age) as int)) as age_at_last_games
			
	from 
		athlete_events inner join 
		noc_regions on
		athlete_events.noc= noc_regions.NOC
	group by 
			id, 
			Name,
			sex;
-- Table showing the different games that has been hosted since the start of the data collection 			
CREATE table if not exists Games
as
			
SELECT 
		DISTINCT City||'_'||Year as game_id,
		Games,
		Year,
		Season,
		City
from athlete_events		
order by year	;

-- Creating a table to show the unique sporting events that takes place at the olympics
Create table if not EXISTS Sport 
as
select 
		DISTINCT Sport,
		substr(sport,1,4) ||'_'||1 as sport_id
from 
		athlete_events ;


--Creating table for the different events that occurs at the Games and the sports they are related to 

Create table if not EXISTS Events 
as
		
select
		DISTINCT Event,
		replace(event,' ','') as event_id,
		substr(sport,1,4) ||'_'||1 as sport_id
from athlete_events	;	


--Creating a table for the list of all winners in the athlete_events table
Create table if not exists medal_winners as
select
	id as winner_id,
	name,
	age, 
	year, 
	City||'_'||Year as game_id,
	substr(sport,1,4) ||'_'||1 as sport_id,
	replace(event,' ','') as event_id, medal as medal_won
from athlete_events 
where medal != 'NA';

-- creating a table for all the participants
Create table if not exists Events_participated
as
select 
		City||'_'||Year as game_id,
		id as player_id,
		athlete_events.Games as Games,
		replace(event,' ','') as event_id,
		City
from athlete_events;



		
