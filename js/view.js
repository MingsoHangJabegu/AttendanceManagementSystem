var table = document.querySelector('table')

var username = sessionStorage.getItem('name')
//create element and render student
function renderStudent(doc) {
    var name = doc.data().name
    var phone = doc.data().phone
    var faculty = doc.data().faculty
    var year = doc.data().year
    var today = doc.data().today
    var roll = doc.data().roll
    var attendance
    var attendanceTime
    var attColor

    if (today == "") {
        attendance = "Absent"
        attendanceTime = "-"
        attColor = "red"
    }
    else {
        attendanceTime = today
        attendance = "Present"
        attColor = "green"
    }
    // console.log(attColor)

    var template = `
        <tr>
            <td class = "time">${roll}</td>
            <td>${name}</td>
            <td>${faculty}</td>
            <td>${year}</td>
            <td>${phone}</td>
            <td class = "data" style="background-color: ${attColor};">${attendance}</td>
            <td class = "time" id = "time">${attendanceTime}</td>
            <td><button class="save">Save</button>
            <button class="edit">Edit</button></td>
            </tr>
            `
    table.innerHTML += template
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

var flag = 0

$(document).on('click', '.edit', function () {
    $(this).parent().siblings('td.data').each(function () {
        //   var content = $(this).html()
        $(this).html('<select id = attendanceEdit> <option value = "Present"> Present </option> <option value = "Absent"> Absent </option> </select>')
    })

    $(this).siblings('.save').show()
    $(this).hide()
})

$(document).on('click', '.edit', function () {
    $(this).parent().siblings('td.time').each(function () {
        var content = $(this).html()
        $(this).html('<input value = ' + content + '>')
    })

    $(this).siblings('.save').show()
    $(this).hide()
})

$(document).on('click', '.save', function () {

    var rollChange = ''
    var time = ''
    $('input').each(function () {
        content = $(this).val()
        console.log("content")
        if (content[0].toLowerCase() == 'b' || content[0].toLowerCase() == 'c') {
            rollChange = content
            console.log("Test")
        } else {
            time = content
        }
        $('select').each(function () {
        flag = 0
        var content = $(this).val()
        if (content == "Present") {
            flag = 1
        }
        $(this).html(content)
        $(this).contents().unwrap()
    })
    })

    db.collection('students').get().then((snapshot) => {
        snapshot.docs.forEach(function (doc) {
            var id = doc.id
            var roll = doc.data().roll
            var sem = doc.data().semester
            console.log(rollChange)

            var today = new Date()
            var dd = String(today.getDate()).padStart(2, '0')
            var mm = String(today.getMonth() + 1).padStart(2, '0') //January is 0!
            var yyyy = today.getFullYear()
            var remarks = ""

            var x = 0
            if (flag == 1) {
                x = 1
            } else {
                x = -1
                time = ""
            }

            const increment = firebase.firestore.FieldValue.increment(x)
            today = yyyy + '-' + mm + '-' + dd

            if (roll == rollChange) {
                db.collection('students').doc('' + [id]).update({
                    today: time,
                    present: increment,
                })

                setTimeout(resetData, 3600000 * 6)
                if (flag == 1) {
                    while (remarks == "") {
                        remarks = prompt("Please enter the reason", "")
                    }
                    db.collection('students').doc('' + [id]).collection('' + [sem]).doc(today).set({
                        status: 'Present',
                        attendanceTime: time,
                        remarks: 'Changed by ' + username + '. Reason: ' + remarks,
                        semester: sem,
                    })
                } else {
                    db.collection('students').doc('' + [id]).collection('' + [sem]).doc(today).delete()
                }
            }

            function resetData() {
                db.collection('students').doc('' + [id]).update({
                    today: '',
                })
            }
        })
    })
    $(this).siblings('.edit').show()
    $(this).hide()

})


//   TODO : USE ADMIN NAME IN REMARKS AFTER ADMIN IS MADE

