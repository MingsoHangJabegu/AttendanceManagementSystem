
document.getElementById('myForm').addEventListener('submit', submitForm)
function getInputVal(id) {
    return document.getElementById(id).value
}

async function submitForm(e) {
    e.preventDefault()

    //GET VALUES
    var Name = getInputVal('name')
    var Email = getInputVal('email')
    var Password = getInputVal('pwd')
    var Phone = getInputVal('phone')
    var Year = getInputVal('year')
    var Faculty = getInputVal('faculty')
    var Roll = getInputVal('roll')

    const file = document.getElementById('image').files[0]
    const fName = new Date() + "-" + Name
    const metadata = {
        contentType: file.type
    }
    	var message =""
	    	const citiesRef = db.collection('students');
			const snapshot = await citiesRef.get();
			snapshot.forEach(doc => {
	  			if (doc.data().roll == Roll){
	  				message = "The roll number already exists"
	  				return alert(message)
	  			}
		})
		
    if(Roll.toUpperCase().includes(Faculty)){
		if(message == ""){
			firebase.auth().createUserWithEmailAndPassword(Email, Password).then(function () {
        var id = firebase.auth().currentUser.uid

        firebase.storage().ref('Images/' + fName).put(file, metadata)
            .then(snapshot => snapshot.ref.getDownloadURL())
            .then(url => {
                imgURL = url
                db.collection('students').doc('' + [id]).set({
                    name: Name,
                    email: Email,
                    password: Password,
                    phone: Phone,
                    year: Year,
                    faculty: Faculty,
                    image: imgURL,
                    roll: Roll,
                    today: '',
                    present: 0,
                    semester: 1,
                })
            })
            .catch(console.log(error))
    })
        .catch((error) => {
            if (error != 'ReferenceError: error is not defined') {
                alert(error)
            } else {
                alert('User created')
                document.getElementById('myForm').reset()
            }
        })
		}
		
    		
    } else {
    	alert('Roll Number and Faculty do not match.')
    }
		}
    
