const addTaskBtn = document.getElementById('add-task');
const taskList = document.getElementById('tasks');
const taskNameInput = document.getElementById('task-name');
const taskDescriptionInput = document.getElementById('task-description');

// Function to fetch tasks from the server and display them
function fetchTasks() {
    fetch('/tasks')
        .then(response => response.json())
        .then(tasks => {
            taskList.innerHTML = ''; // Clear the list before re-rendering
            tasks.forEach(task => {
                const li = document.createElement('li');
                li.className = 'task';
                li.textContent = `${task.name}: ${task.description}`;
                taskList.appendChild(li);
            });
        })
        .catch(error => {
            console.error('Error fetching tasks:', error);
        });
}

// Call the fetchTasks function on page load to show the current tasks
fetchTasks();

// Function to add a new task
addTaskBtn.addEventListener('click', () => {
    const taskName = taskNameInput.value.trim();
    const taskDescription = taskDescriptionInput.value.trim();

    if (taskName && taskDescription) {
        fetch('/tasks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: taskName, description: taskDescription })
        })
        .then(response => response.json())
        .then(() => {
            taskNameInput.value = '';  // Clear the input fields
            taskDescriptionInput.value = '';
            fetchTasks();  // Refresh the task list
        })
        .catch(error => {
            console.error('Error adding task:', error);
        });
    }
});

