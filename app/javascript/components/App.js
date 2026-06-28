import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [dueDate, setDueDate] = useState('');

  useEffect(() => {
    axios.get('/tasks')
      .then(response => {
        setTasks(response.data);
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  const handleSubmit = (event) => {
    event.preventDefault();
    axios.post('/tasks', {
      task: {
        title: title,
        description: description,
        due_date: dueDate,
      },
    })
      .then(response => {
        setTasks([...tasks, response.data]);
        setTitle('');
        setDescription('');
        setDueDate('');
      })
      .catch(error => {
        console.error(error);
      });
  };

  return (
    <div>
      <h1>Task Tracker</h1>
      <form onSubmit={handleSubmit}>
        <label>
          Title:
          <input type="text" value={title} onChange={(event) => setTitle(event.target.value)} />
        </label>
        <br />
        <label>
          Description:
          <textarea value={description} onChange={(event) => setDescription(event.target.value)} />
        </label>
        <br />
        <label>
          Due Date:
          <input type="date" value={dueDate} onChange={(event) => setDueDate(event.target.value)} />
        </label>
        <br />
        <button type="submit">Create Task</button>
      </form>
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <h2>{task.title}</h2>
            <p>{task.description}</p>
            <p>Due Date: {task.due_date}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;