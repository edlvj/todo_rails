SQL task

get all statuses, not repeating, alphabetically ordered

SELECT DISTINCT status FROM tasks ORDER BY status;

get the count of all tasks in each project, order by tasks count descending

SELECT COUNT(*) AS amount, projects.name FROM tasks INNER JOIN projects ON project_id = projects.id GROUP BY projects.name ORDER BY amount DESC;

get the count of all tasks in each project, order by projects names

SELECT COUNT(*) AS amount, projects.name FROM tasks INNER JOIN projects ON project_id = projects.id GROUP BY projects.name ORDER BY projects.name ASC;

get the tasks for all projects having the name beginning with “N” letter

SELECT * FROM tasks WHERE name like 'N%';

get the list of all projects containing the ‘a’ letter in the middle of the name, and show the tasks count near each project. Mention that there can exist projects without tasks and tasks with project_id=NULL

SELECT projects.name, COUNT(tasks.id) FROM projects RIGHT JOIN tasks ON projects.id = project_id WHERE projects.name LIKE '%a%' GROUP BY projects.name;

get the list of tasks with duplicate names. Order alphabetically

SELECT tasks.name, tasks.id FROM tasks INNER JOIN (SELECT id, name FROM tasks GROUP BY name HAVING count(id) > 1) dup ON tasks.name = dup.name ORDER BY tasks.name ;

get the list of tasks having several exact matches of both name and status, from the project ‘Garage’. Order by matches count

SELECT tasks.name, tasks.id, tasks.status FROM tasks INNER JOIN (SELECT id, status, name FROM tasks GROUP BY status HAVING count(id) > 1) dup ON tasks.status = dup.status WHERE project_id = (SELECT id FROM projects WHERE name = 'GARAGE') ORDER BY tasks.name;

get the list of project names having more than 10 tasks in status ‘completed’. Order by project_id

SELECT projects.name, COUNT(tasks.id) as count FROM projects RIGHT JOIN tasks ON projects.id = tasks.project_id WHERE tasks.status = 'completed' GROUP BY projects.name HAVING count > 10 ORDER BY projects.id;