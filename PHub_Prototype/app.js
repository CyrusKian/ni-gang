// Initial Mock Database State
let rooms = [
    { id: 1, number: 'Room 101', type: 'Private', status: 'Available', patient: 'None', staff: 'Unassigned' },
    { id: 2, number: 'Room 102', type: 'Semi-Private', status: 'Occupied', patient: 'Juan Dela Cruz', staff: 'Dr. Santos (Doctor)' },
    { id: 3, number: 'Room 103', type: 'ICU', status: 'Cleaning', patient: 'None', staff: 'Unassigned' },
    { id: 4, number: 'Room 104', type: 'Ward', status: 'Available', patient: 'None', staff: 'Unassigned' }
];

let patients = [
    { id: 1, name: 'Juan Dela Cruz', room: 'Room 102', admissionDate: '2026-10-01' }
];

let cleaningSchedules = [
    { id: 1, room: 'Room 103', time: '2026-10-03 14:00 (Google Calendar API)', status: 'Pending Cleaning' }
];

// DOM Elements
const loginContainer = document.getElementById('login-container');
const dashboardContainer = document.getElementById('dashboard-container');
const loginForm = document.getElementById('login-form');
const loginError = document.getElementById('login-error');
const logoutBtn = document.getElementById('logout-btn');
const userRoleBadge = document.getElementById('user-role-badge');

// Tabs Switching
const tabBtns = document.querySelectorAll('.tab-btn');
const tabPanes = document.querySelectorAll('.tab-pane');

tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        tabBtns.forEach(b => b.classList.remove('active'));
        tabPanes.forEach(p => p.classList.remove('active'));
        btn.classList.add('active');
        document.getElementById(btn.dataset.target).classList.add('active');
    });
});

// Authentication handling credentials.txt
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const usernameInput = document.getElementById('username').value.trim();
    const passwordInput = document.getElementById('password').value.trim();

    try {
        const response = await fetch('credentials.txt');
        const text = await response.text();
        const lines = text.split('\n');
        
        let authenticatedUser = null;
        for (let line of lines) {
            const [user, pass, role] = line.trim().split(',');
            if (user === usernameInput && pass === passwordInput) {
                authenticatedUser = { user, role };
                break;
            }
        }

        if (authenticatedUser) {
            loginError.textContent = '';
            loginContainer.classList.add('hidden');
            dashboardContainer.classList.remove('hidden');
            userRoleBadge.textContent = `Role: ${authenticatedUser.role}`;
            renderAll();
        } else {
            loginError.textContent = 'Invalid username or password from credentials.txt';
        }
    } catch (err) {
        loginError.textContent = 'Error reading credentials.txt. Make sure it is in the same folder.';
        console.error(err);
    }
});

logoutBtn.addEventListener('click', () => {
    dashboardContainer.classList.add('hidden');
    loginContainer.classList.remove('hidden');
    loginForm.reset();
});

// Render Functions
function renderAll() {
    renderRooms();
    renderPatients();
    renderCleaning();
    populateSelectDropdowns();
}

function renderRooms() {
    const tbody = document.querySelector('#rooms-table tbody');
    tbody.innerHTML = '';
    rooms.forEach(room => {
        tbody.innerHTML += `
            <tr>
                <td>${room.number}</td>
                <td>${room.type}</td>
                <td><span class="status-badge status-${room.status.toLowerCase()}">${room.status}</span></td>
                <td>${room.patient}</td>
                <td>${room.staff}</td>
                <td><button class="btn secondary-btn" onclick="openRoomModal(${room.id})">Update Status</button></td>
            </tr>
        `;
    });
}

function renderPatients() {
    const tbody = document.querySelector('#patients-table tbody');
    tbody.innerHTML = '';
    patients.forEach(pat => {
        tbody.innerHTML += `
            <tr>
                <td>${pat.name}</td>
                <td>${pat.room}</td>
                <td>${pat.admissionDate}</td>
                <td><button class="btn danger-btn" onclick="dischargePatient(${pat.id})">Discharge</button></td>
            </tr>
        `;
    });
}

function renderCleaning() {
    const tbody = document.querySelector('#cleaning-table tbody');
    tbody.innerHTML = '';
    cleaningSchedules.forEach(item => {
        tbody.innerHTML += `
            <tr>
                <td>${item.room}</td>
                <td>${item.time}</td>
                <td><span class="status-badge status-cleaning">${item.status}</span></td>
                <td><button class="btn primary-btn" onclick="acknowledgeCleaning(${item.id})">Acknowledge & Set Available</button></td>
            </tr>
        `;
    });
}

function populateSelectDropdowns() {
    const availableRoomsSelect = document.getElementById('available-rooms-select');
    const staffRoomSelect = document.getElementById('staff-room-select');
    
    availableRoomsSelect.innerHTML = '';
    staffRoomSelect.innerHTML = '';

    rooms.forEach(room => {
        if (room.status === 'Available') {
            availableRoomsSelect.innerHTML += `<option value="${room.number}">${room.number} (${room.type})</option>`;
        }
        staffRoomSelect.innerHTML += `<option value="${room.number}">${room.number}</option>`;
    });
}

// Room Update Modal Logic
const roomModal = document.getElementById('room-modal');
const closeModalBtn = document.getElementById('close-modal-btn');
const roomUpdateForm = document.getElementById('room-update-form');

function openRoomModal(roomId) {
    const room = rooms.find(r => r.id === roomId);
    document.getElementById('modal-room-id').value = room.id;
    document.getElementById('modal-room-no').value = room.number;
    document.getElementById('modal-room-status').value = room.status;
    roomModal.classList.remove('hidden');
}

closeModalBtn.addEventListener('click', () => {
    roomModal.classList.add('hidden');
});

roomUpdateForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const id = parseInt(document.getElementById('modal-room-id').value);
    const newStatus = document.getElementById('modal-room-status').value;
    
    const room = rooms.find(r => r.id === id);
    if(room) {
        room.status = newStatus;
    }
    roomModal.classList.add('hidden');
    renderAll();
});

// Manage Patient: Admission Flow
const admissionForm = document.getElementById('admission-form');
admissionForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const name = document.getElementById('patient-name').value;
    const roomNo = document.getElementById('available-rooms-select').value;

    patients.push({
        id: patients.length + 1,
        name: name,
        room: roomNo,
        admissionDate: new Date().toISOString().split('T')[0]
    });

    const room = rooms.find(r => r.number === roomNo);
    if(room) {
        room.status = 'Occupied';
        room.patient = name;
    }

    admissionForm.reset();
    renderAll();
});

// Manage Patient: Discharge Flow (Triggers Google Calendar cleaning schedule)
function dischargePatient(patientId) {
    const patientIndex = patients.findIndex(p => p.id === patientId);
    if (patientIndex === -1) return;

    const patient = patients[patientIndex];
    const room = rooms.find(r => r.number === patient.room);

    if (room) {
        room.status = 'Cleaning';
        room.patient = 'None';
        room.staff = 'Unassigned';

        // Trigger Google Calendar cleaning schedule simulation
        cleaningSchedules.push({
            id: cleaningSchedules.length + 1,
            room: room.number,
            time: new Date(Date.now() + 3600000).toLocaleString() + ' (Google Calendar API)',
            status: 'Cleaning Scheduled'
        });
    }

    patients.splice(patientIndex, 1);
    renderAll();
}

// Manage Staff Flow
const staffAssignmentForm = document.getElementById('staff-assignment-form');
staffAssignmentForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const role = document.getElementById('staff-role-select').value;
    const name = document.getElementById('staff-name').value;
    const roomNo = document.getElementById('staff-room-select').value;

    const room = rooms.find(r => r.number === roomNo);
    if(room) {
        room.staff = `${name} (${role})`;
    }

    staffAssignmentForm.reset();
    renderAll();
});

// Cleaning Acknowledge Flow (Sets room back to available)
function acknowledgeCleaning(scheduleId) {
    const index = cleaningSchedules.findIndex(s => s.id === scheduleId);
    if(index === -1) return;

    const item = cleaningSchedules[index];
    const room = rooms.find(r => r.number === item.room);
    if(room) {
        room.status = 'Available';
    }

    cleaningSchedules.splice(index, 1);
    renderAll();
}