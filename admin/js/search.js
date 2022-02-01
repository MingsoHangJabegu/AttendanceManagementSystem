function searchUser() {
    var roll = document.getElementById('roll').value
    var semester = document.getElementById('semester').value
    localStorage.setItem('roll', roll)
    localStorage.setItem('semester', semester)
}