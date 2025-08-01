with ctes as
(
select 
started_at,
to_timestamp(started_at) as started_at_time,
date(to_timestamp(started_at)) as date,
hour(to_timestamp(started_at)) as hour_started_at,
dayname(to_timestamp(started_at)) as dayname,
case 
when dayname(to_timestamp(started_at)) in ('Sat','Sun') then 'weekend'
else 'businessDay'
end as working,
case 
when month(to_timestamp(started_at)) in (12,1,2) then 'winter'
when month(to_timestamp(started_at)) in (3,4,5) then 'spring'
when month(to_timestamp(started_at)) in (6,7,8) then 'summer'
else 'Autumn'
end as station_of_Year
  from {{ source('demo', 'bike') }} 
  where  started_at !='started_at'
)

select 
* from ctes