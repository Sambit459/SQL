use project;

select * from CovidDeaths
order by 3, 4 ;

select location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths
order by 1,2;


--total cases vs total deaths
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
order by 1,2;

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
where location like '%states%';

--total caeses vs population
select location,date,total_cases,population,(total_cases/population)*100 as PopulationInfected_percent
from CovidDeaths
where location like '%states%'
order by 1,2;

-- Countries with Highest Infection Rate compared to Population
select location, population, max(total_cases) as highest_infection_count , max((total_cases/population))*100 as PopulationInfected_percent
from CovidDeaths
group by location,population
order by PopulationInfected_percent desc;

-- Countries with Highest Death Count

alter table CovidDeaths alter column total_deaths int;
alter table CovidDeaths alter column new_deaths int;

select location,max(total_deaths) as total_death_count from CovidDeaths
where continent is not null
group by location
order by total_death_count desc ;

-- Death count by continent
select continent,max(total_deaths) as total_death_count from CovidDeaths
where continent is not null
group by continent
order by total_death_count desc ;

--Global numbers by date
select date , sum(new_cases) as total_case
from CovidDeaths
group by date
order by total_case desc;


Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths;

--total population vs vaccination

select *  from CovidDeaths cd join CovidVaccinations cv
on cd.location=cv.location
and cd.date=cv.date;

select cd.continent,cd.Location,cd.date,cd.population,cv.new_vaccinations 
from CovidDeaths cd join CovidVaccinations cv
on cd.location=cv.location
and cd.date=cv.date
where cd.continent is not null
order by  2,3;

select cd.continent,cd.Location,cd.date,cd.population,cv.new_vaccinations,
sum(convert(int,cv.new_vaccinations)) over (partition by cd.location order by cd.location ,cd.date) as rolling_vaccinated_population
from CovidDeaths cd join CovidVaccinations cv
on cd.location=cv.location
and cd.date=cv.date
where cd.continent is not null
order by  2,3;








