/*
   IFT1148 - TP3
   Stéphane Barthélemy
   20084771 - barthste
*/


/* ===== VALIDATION CLIENT ===== */
	

//Constantes
var TP1_NOTE_MAX = 10;
var TP2_NOTE_MAX = 10;
var TP3_NOTE_MAX = 20;
var INTRA_NOTE_MAX = 100;
var FINAL_NOTE_MAX = 100;

//Messages d'erreurs
var ERROR_MESSAGE_NOTE_DEFAUT = "Veuillez entrer une note valide";
var ERROR_MESSAGE_NOTE_RANGE = "La note doit être entre";
var ERROR_MESSAGE_R_FINAL = "Le code R ne peut pas être utilisée ici";

var rangeValueMax;

// Validation Client des champs
function customClientValidation(source, args){
    	
    var RawValue = args.Value;                      // Valeur brute du champ
    var NumberValue = parseFloat(args.Value);       // Valeur numérique du champ
    var textBoxTraite = source.controltovalidate;   // Champ traité

    //Non valide par défaut
    args.IsValid = false;

    //Est-ce un "R"
    if (RawValue.toUpperCase() == "R"){
        // Sauf pour l'examen final
        if (textBoxTraite.toUpperCase().includes("FINAL")) {
            source.innerHTML  = ERROR_MESSAGE_R_FINAL;
        }else{
            //Sinon, c'est valide
            args.IsValid = true;
        }
        return;
    }

    // Est-ce un nombre ?
    if(isNaN(NumberValue)){
        //Ce n'est pas un nombre
        source.innerHTML  = ERROR_MESSAGE_NOTE_DEFAUT;
    }else{
        //Le nombre est dans le bon interval
        if (isInRange(textBoxTraite, NumberValue)) {
            //Validation Ok
            args.IsValid = true;
        }else{
            //Hors interval
            source.innerHTML = ERROR_MESSAGE_NOTE_RANGE + " 0 et " + rangeValueMax;
        }
    }
}

//Renvoie si la note est dans l'interval prévu
function isInRange(textBoxId, value){
	if(textBoxId.toUpperCase().includes("TP1")){
		rangeValueMax = TP1_NOTE_MAX;
		return value >= 0 && value <= TP1_NOTE_MAX;
	}
	if(textBoxId.toUpperCase().includes("TP2")){
		rangeValueMax = TP2_NOTE_MAX;
		return value >= 0 && value <= TP2_NOTE_MAX;
	}
	if(textBoxId.toUpperCase().includes("TP3")){
		rangeValueMax = TP3_NOTE_MAX;
		return value >= 0 && value <= TP3_NOTE_MAX;
	}
	if(textBoxId.toUpperCase().includes("INTRA")){
		rangeValueMax = INTRA_NOTE_MAX;
		return value >= 0 && value <= INTRA_NOTE_MAX;
	}
	if(textBoxId.toUpperCase().includes("FINAL")){
		rangeValueMax = FINAL_NOTE_MAX;
		return value >= 0 && value <= FINAL_NOTE_MAX;
	}
	return false;    
}