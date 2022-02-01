function includeHTML() {
  var z, i, elmnt, file, xhttp
  /*loop through a collection of all HTML elements:*/
  z = document.getElementsByTagName("*")
  for (i = 0; i < z.length; i++) {
    elmnt = z[i]
    /*search for elements with a certain atrribute:*/
    file = elmnt.getAttribute("w3-include-html")
    if (file) {
      /*make an HTTP request using the attribute value as the file name:*/
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function () {
        if (this.readyState == 4) {
          if (this.status == 200) { elmnt.innerHTML = this.responseText; }
          if (this.status == 404) { elmnt.innerHTML = "Page not found."; }
          /*remove the attribute, and call this function once more:*/
          elmnt.removeAttribute("w3-include-html")
          includeHTML()
        }
      }
      xhttp.open("GET", file, true)
      xhttp.send()
      /*exit the function:*/
      return
    }
  }
}

function selectDay() {
  var day = confirm("Press 'OK' if tomorrow is a holiday or 'Cancel' if tomorrow is a working day")

  if (day) {
    db.collection('day').doc('type').update({
      'today': 'holiday',
    })

    db.collection('students').get().then((snapshot) => {
      snapshot.docs.forEach(doc => {
        renderHoliday(doc)
      })
    })
    alert("Tomorrow is a holiday.")
  } else {
    db.collection('day').doc('type').update({
      'today': 'working',
    })

    const increment = firebase.firestore.FieldValue.increment(1)
    db.collection('day').doc('totalWorkingDays').update({
      'total': increment,
    })

    db.collection('students').get().then((snapshot) => {
      snapshot.docs.forEach(doc => {
        renderWorking(doc)
      })
    })
    alert("Tomorrow is a working day.")
  }

  function renderHoliday(doc) {
    var id = doc.id
    var semester = doc.data().semester

    var nextDay = new Date()
    nextDay.setDate(nextDay.getDate() + 1)
    var dd = String(nextDay.getDate()).padStart(2, '0')
    var mm = String(nextDay.getMonth() + 1).padStart(2, '0') //January is 0!
    var yyyy = nextDay.getFullYear()
    nextDay = yyyy + '-' + mm + '-' + dd

    db.collection('students').doc('' + [id]).collection('' + [semester]).doc(nextDay).set({
      semester: semester,
      status: 'holiday'
    })
  }

  function renderWorking(doc) {
    var id = doc.id
    var semester = doc.data().semester

    var nextDay = new Date()
    nextDay.setDate(nextDay.getDate() +1)
    var dd = String(nextDay.getDate()).padStart(2, '0')
    var mm = String(nextDay.getMonth() + 1).padStart(2, '0') //January is 0!
    var yyyy = nextDay.getFullYear()
    nextDay = yyyy + '-' + mm + '-' + dd


    db.collection('students').doc('' + [id]).collection('' + [semester]).doc(nextDay).set({
      semester: semester,
      status: 'Absent',
      attendanceTime: '-',
      remarks: '-',
    })
    
  }
}

function newSemester() {
  var sem = confirm("Has the new semester begun?")

  if (sem) {
    db.collection('students').get().then((snapshot) => {
      snapshot.docs.forEach(doc => {
        renderStudent(doc)
      })
    })
    db.collection('day').doc('totalWorkingDays').update({
      'total': 0,
    })
    alert("Successful!")
  }

  function renderStudent(doc) {
    var id = doc.id
    var roll = doc.data().roll
    var faculty = doc.data().faculty
    var sem = doc.data().semester

    if (sem < 8) {
      const increment = firebase.firestore.FieldValue.increment(1)
      db.collection('students').doc('' + [id]).update({
        'present': 0,
        'semester': increment,
      })
    } else {
      var a = 1
      var b = 1
      var c = 1

      var data = new FormData()
      data.append("roll", roll.toString())
      data.append("faculty", faculty.toString())

      while (a <= 8) {
        db.collection('students').doc('' + [id]).collection('' + [a]).get().then((snapshot) => {
          snapshot.docs.forEach(docu => {
            renderBackup(docu)
          })
        })
        a++
      }
      db.collection('students').doc('' + [id]).delete()
    }
    function renderBackup(docu) {
      var attDate = docu.id
      var attTime = docu.data().attendanceTime
      var remarks = docu.data().remarks
      var status = docu.data().status
      var semester = docu.data().semester

      data.append("attDate", attDate)
      data.append("attTime", attTime)
      data.append("remarks", remarks)
      data.append("status", status)
      data.append("semester", semester)

      var xhr = new XMLHttpRequest()
      xhr.open("POST", "../php/delete.php")
      xhr.onload = function () {
        console.log(this.response)
      }
      xhr.send(data)

      db.collection('students').doc('' + [id]).collection('' + [b]).get().then((snapshot) => {
        snapshot.docs.forEach(docum => {
          renderDelete(docum)
        })
      })
      b++

      function renderDelete(docum) {
        var semest = docum.data().semester
        var date = docum.id
        db.collection('students').doc('' + [id]).collection('' + [semest]).doc('' + [date]).delete()
      }
    }
  }
}
