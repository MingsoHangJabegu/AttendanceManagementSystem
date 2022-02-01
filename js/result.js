var table = document.querySelector('table')

var searchRoll = localStorage.getItem('roll')
var semester = localStorage.getItem('semester')

var heading = document.querySelector('h1')
var heading2 = document.querySelector('h2')

function renderStudent(doc) {
    var id = doc.id
    var roll = doc.data().roll
    var present = doc.data().present


    if (roll == searchRoll) {

        var name = doc.data().name
        var current = doc.data().semester
        var present = doc.data().present

        if (semester == 'current') {
            db.collection('students').doc('' + [id]).collection('' + [current]).get().then((snapshot) => {
                heading.innerHTML = 'Attendance Record of ' + name
                // heading2.innerHTML = 'Total Days Present = ' + present.toString()
                snapshot.docs.forEach(doc => {
                    size = snapshot.docs.length
                    renderAttendance(doc)
                })
            })
            heading2.innerHTML = 'Number of days present = ' + present
        } else {
            db.collection('students').doc('' + [id]).collection('' + [semester]).get().then((snapshot) => {
                heading.innerHTML = 'Attendance Record of ' + name
                // heading2.innerHTML = 'Total Days Present = ' + present.toString()
                snapshot.docs.forEach(doc => {
                    size = snapshot.docs.length
                    renderAttendance(doc)
                })
            })
        }
    }
}

var row_num = 0

function renderAttendance(doc) {

    var attendance = doc.data().status
    var attendanceTime = doc.data().attendanceTime
    var remarks = doc.data().remarks
    var attendanceDate = doc.id
    var attColor

    if (attendance == 'holiday') {
        var template = `
        <tr>
        <td colspan = "5" style = "text-align: center; background-color: brown;">${'HOLIDAY'}</td>
        </tr>
        `
        table.innerHTML += template
    } else {

        if (attendance == 'Present') {
            attColor = 'green'
        } else {
            attColor = 'red'
        }

        row_num++

        var template = `
                <tr>
                <td>${row_num}</td>
                <td>${attendanceDate}</td>
                <td>${attendanceTime}</td>
                <td style="background-color: ${attColor};">${attendance}</td>
                <td>${remarks}</td>
                </tr>
                `
        table.innerHTML += template
    }
}

db.collection('students').get().then((snapshot) => {
    snapshot.docs.forEach(doc => {
        renderStudent(doc)
    })
})


function sortTable(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0
    table = document.getElementById("attendance-table")
    switching = true

    dir = "asc"

    while (switching) {
        switching = false
        rows = table.rows
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false
            x = rows[i].getElementsByTagName("td")[n]
            y = rows[i + 1].getElementsByTagName("td")[n]

            if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    shouldSwitch = true
                    break
                }
            } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    shouldSwitch = true
                    break;
                }
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i])
            switching = true
            switchcount++
        } else {
            if (switchcount == 0 && dir == "asc") {
                dir = "desc"
                switching = true
            }
        }
    }
}

// window.onload = function(){
//     if(flag != 1){
//         alert("No User")
//     } 
// }