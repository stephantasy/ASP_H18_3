
'   IFT1148 -TP3
'   Stéphane Barthélemy
'   20084771 - barthste

Imports System.Diagnostics

Partial Class tp3 : Inherits System.Web.UI.Page

    'Constantes
    Protected Const TP1_NOTE_MAX As Integer = 10
    Protected Const TP2_NOTE_MAX As Integer = 10
    Protected Const TP3_NOTE_MAX As Integer = 20
    Protected Const INTRA_NOTE_MAX As Integer = 100
    Protected Const INTRA_NOTE_PERCENT As Integer = 20
    Protected Const FINAL_NOTE_MAX As Integer = 100
    Protected Const FINAL_NOTE_PERCENT As Integer = 40
    Protected Const NOTE_MAXIMUM As Integer = 100
    Protected Const NOTE_PASSAGE As Double = 49.5
    Protected Const SEUIL_PERCENT As Integer = 40

    'Messages d'erreurs
    Private Const ERROR_MESSAGE_NOTE_DEFAUT As String = "Veuillez entrer une note valide"
    Private Const ERROR_MESSAGE_NOTE_RANGE As String = "La note doit être entre"
    Private Const ERROR_MESSAGE_R_FINAL As String = "Le code R ne peut pas être utilisée ici"



    'Chargement de la page
    'Sub Page_Load() Handles MyBase.Load
    '   'On affiche l'heure de l'accès au serveur
    '   lbHeureAccesServeur.Text = DateTime.Now.ToString()
    'End Sub


    'Insersion d'un nouvel étudiant demandé
    Protected Sub BtInsererClicked(sender As Object, e As EventArgs)
        'Cache le GridView et le bouton
        gvEtudiant.Visible = False
        btInserer.Visible = False

        'Affiche le DetailsView
        dvInsertion.Visible = True

        'On passe le Details View en mode Insertion
        dvInsertion.ChangeMode(DetailsViewMode.Insert)
    End Sub


    'Le mode du Details view à changé : S'il est en mode ReadOnly, on affiche les éléments comme au départ
    Private Sub dvInsertion_ModeChanged(sender As Object, e As EventArgs) Handles dvInsertion.ModeChanged
        If (dvInsertion.DefaultMode = DetailsViewMode.ReadOnly) Then
            'Affiche le GridView et le bouton
            gvEtudiant.Visible = True
            btInserer.Visible = True
            'Cache le DetailsView
            dvInsertion.Visible = False
        End If
    End Sub


    'Renvoie si la note est dans l'interval prévu
    Private Function IsInRange(textBoxId As String, value As Double, ByRef valueMax As Double) As Boolean
        Select Case True
            Case textBoxId.ToUpper().Contains("TP1")
                valueMax = TP1_NOTE_MAX
                Return value >= 0 And value <= TP1_NOTE_MAX
            Case textBoxId.ToUpper().Contains("TP2")
                valueMax = TP2_NOTE_MAX
                Return value >= 0 And value <= TP2_NOTE_MAX
            Case textBoxId.ToUpper().Contains("TP3")
                valueMax = TP3_NOTE_MAX
                Return value >= 0 And value <= TP3_NOTE_MAX
            Case textBoxId.ToUpper().Contains("INTRA")
                valueMax = INTRA_NOTE_MAX
                Return value >= 0 And value <= INTRA_NOTE_MAX
            Case textBoxId.ToUpper().Contains("FINAL")
                valueMax = FINAL_NOTE_MAX
                Return value >= 0 And value <= FINAL_NOTE_MAX
            Case Else
                Return False
        End Select
    End Function

    'Validation des champs correspondants aux notes
    Protected Sub CustomServerValidation(source As Object, args As ServerValidateEventArgs)

        Dim localizedValue As String    'Valeur du champ "localisé" (avec "." ou "," selon la localisation)
        Dim NumberValue As Double       'Valeur numérique du champ
        Dim textBoxTraite As TextBox = FindControl(source.ControlToValidate)    'TextBox controlée
        Dim rangeValueMax As Double     'Valeur maximale permise pour la note

        ' Non valide par défaut
        args.IsValid = False

        'Est-ce un "R"
        If (args.Value.ToUpper() = "R") Then
            ' Sauf pour l'examen final
            If (textBoxTraite.ID.ToUpper().Contains("FINAL")) Then   'textBoxTraite.ID = "TbNoteFinal" Or textBoxTraite.ID = "tbDvInsertFinal"
                source.ErrorMessage = ERROR_MESSAGE_R_FINAL
            Else
                'Sinon, c'est valide
                args.IsValid = True
            End If
            Return
        End If

        'Si la culture locale est en anglais, on remplace les "," par des ".", sinon on fait l'inverse.
        If (Globalization.CultureInfo.CurrentCulture.ToString.IndexOf("en") >= 0) Then
            localizedValue = args.Value.Replace(",", ".")
        Else
            localizedValue = args.Value.Replace(".", ",")
        End If

        'Est-ce bien un nombre (à contrôler après la localisation !)
        Try
            NumberValue = Double.Parse(localizedValue)
        Catch ex As Exception
            'Ce n'est pas un nombre, on arrête la validation
            source.ErrorMessage = ERROR_MESSAGE_NOTE_DEFAUT
            Return
        End Try

        'Le nombre est dans le bon interval
        If (IsInRange(textBoxTraite.ID, NumberValue, rangeValueMax)) Then

            'On remplace avec le bon séparateur (au besoin), avec 1 décimale
            textBoxTraite.Text = Math.Round(NumberValue, 1).ToString()

            'Validation Ok
            args.IsValid = True
        Else
            'Hors interval
            source.ErrorMessage = ERROR_MESSAGE_NOTE_RANGE + " 0 et " + rangeValueMax
        End If
    End Sub


    'Affiche et cache le rapport
    Protected Sub btRapport_Click(sender As Object, e As EventArgs) Handles btRapport.Click
        gvRapport.Visible = Not (gvRapport.Visible)
    End Sub



    'Renvoie un code binaire où les 1 indiquent qu'un R est présent dans le champ concerné 
    Private Function GetR_ByteCode(notes As Notes) As Byte
        Dim rByteCode As Byte = 0
        rByteCode = If(notes.tp1.ToUpper() = "R", rByteCode Or 1, rByteCode And 254)     '1er bit pour le TP1
        rByteCode = If(notes.tp2.ToUpper() = "R", rByteCode Or 2, rByteCode And 253)     '2e bit pour le TP2
        rByteCode = If(notes.tp3.ToUpper() = "R", rByteCode Or 4, rByteCode And 251)     '3e bit pour le TP3
        rByteCode = If(notes.intra.ToUpper() = "R", rByteCode Or 8, rByteCode And 247)   '4e bit pour l'intra
        Return rByteCode
    End Function

    'Calcul des notes pour les TP
    Private Sub GetNotesTp(notes As Notes, codeR As Byte, intra As Double, final As Double, ByRef tp1Temp As Double, ByRef tp2Temp As Double, ByRef tp3Temp As Double)
        Select Case (codeR And 247) ' (on ignore le bit de l'intra)
            Case 1  ' Manque que le TP 1
                tp2Temp = Double.Parse(notes.tp2)
                tp3Temp = Double.Parse(notes.tp3)
                tp1Temp = ((tp2Temp / TP2_NOTE_MAX * TP1_NOTE_MAX) + (tp3Temp / TP3_NOTE_MAX * TP1_NOTE_MAX)) / 2
            Case 2 ' Manque que le TP 2
                tp1Temp = Double.Parse(notes.tp1)
                tp3Temp = Double.Parse(notes.tp3)
                tp2Temp = ((tp1Temp / TP1_NOTE_MAX * TP2_NOTE_MAX) + (tp3Temp / TP3_NOTE_MAX * TP2_NOTE_MAX)) / 2
            Case 4 ' Manque que le TP 3
                tp1Temp = Double.Parse(notes.tp1)
                tp2Temp = Double.Parse(notes.tp2)
                tp3Temp = ((tp1Temp / TP1_NOTE_MAX * TP2_NOTE_MAX) + (tp2Temp / TP2_NOTE_MAX * TP1_NOTE_MAX)) / 2
            Case 3 ' Manque les TP 1 et 2
                tp3Temp = Double.Parse(notes.tp3)
                tp1Temp = (tp3Temp / TP3_NOTE_MAX * TP1_NOTE_MAX)
                tp2Temp = (tp3Temp / TP3_NOTE_MAX * TP2_NOTE_MAX)
            Case 5 ' Manque les TP 1 et 3
                tp2Temp = Double.Parse(notes.tp2)
                tp1Temp = (tp2Temp / TP2_NOTE_MAX * TP1_NOTE_MAX)
                tp3Temp = (tp2Temp / TP2_NOTE_MAX * TP3_NOTE_MAX)
            Case 6 ' Manque les TP 2 et 3
                tp1Temp = Double.Parse(notes.tp1)
                tp2Temp = (tp1Temp / TP1_NOTE_MAX * TP2_NOTE_MAX)
                tp3Temp = (tp1Temp / TP1_NOTE_MAX * TP3_NOTE_MAX)
            Case 7 ' Manque les TP 1, 2 et 3
                tp1Temp = ((intra / INTRA_NOTE_PERCENT * TP1_NOTE_MAX) + (final / FINAL_NOTE_PERCENT * TP1_NOTE_MAX)) / 2
                tp2Temp = ((intra / INTRA_NOTE_PERCENT * TP2_NOTE_MAX) + (final / FINAL_NOTE_PERCENT * TP2_NOTE_MAX)) / 2
                tp3Temp = ((intra / INTRA_NOTE_PERCENT * TP3_NOTE_MAX) + (final / FINAL_NOTE_PERCENT * TP3_NOTE_MAX)) / 2
            Case Else ' Toutes les notes de TP sont là
                tp1Temp = Double.Parse(notes.tp1)
                tp2Temp = Double.Parse(notes.tp2)
                tp3Temp = Double.Parse(notes.tp3)
        End Select
    End Sub



    'Calcule les résultats des TP et des examens et les affectes aux variables passées par référence
    Private Sub CalculNotes(notes As Notes, ByRef tp As Double, ByRef intra As Double, ByRef final As Double, ByRef exam As Double)

        Dim tp1Temp, tp2Temp, tp3Temp As Double
        Dim codeR As Byte = GetR_ByteCode(notes)         'Récupère un Byte où les 4 premiers bits indiquent si un champ contient un R

        'Examen Final
        final = Integer.Parse(notes.Final) / FINAL_NOTE_MAX * FINAL_NOTE_PERCENT

        'Traitement pour l'Intra
        If (codeR And 8) Then
            intra = Double.Parse(notes.Final) / FINAL_NOTE_MAX * INTRA_NOTE_PERCENT
        Else
            intra = Double.Parse(notes.intra) / INTRA_NOTE_MAX * INTRA_NOTE_PERCENT
        End If

        'On récupère les notes des 3 TP
        GetNotesTp(notes, codeR, intra, final, tp1Temp, tp2Temp, tp3Temp)

        'Total des TP
        tp = tp1Temp + tp2Temp + tp3Temp

        'Total des examens
        exam = intra + final

    End Sub

    ' Renvoie si le seuil à été atteint en fonction de la note rçue en paramètre
    Private Function IsSeuilReached(note As Double) As Boolean
        Return note >= ((INTRA_NOTE_PERCENT + FINAL_NOTE_PERCENT) / NOTE_MAXIMUM * SEUIL_PERCENT)
    End Function

    'Mise à jour du rapport
    Private Sub gvRapport_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRapport.RowDataBound
        'On ne traite que les tuples
        If e.Row.RowType = DataControlRowType.DataRow Then
            ' Variables
            Dim resultatTravaux, resultaIntra, resultaFinal, resultExamen, resultat As Double
            Dim seuilAtteint As Boolean = False
            Dim message As String = "Échec"

            'On récupère les notes du tuple
            Dim notes As Notes
            notes.tp1 = e.Row.Cells(4).Text
            notes.tp2 = e.Row.Cells(5).Text
            notes.tp3 = e.Row.Cells(6).Text
            notes.intra = e.Row.Cells(7).Text
            notes.Final = e.Row.Cells(8).Text

            ' Calcul des résultats
            CalculNotes(notes, resultatTravaux, resultaIntra, resultaFinal, resultExamen)

            'Contrôle du seuil
            seuilAtteint = IsSeuilReached(resultExamen)

            'Calcul de la note finale en fonction du seuil
            If (seuilAtteint) Then
                resultat = resultatTravaux + resultExamen
            Else
                resultat = resultExamen
                message += ": seuil non respecté"
            End If

            'Est-ce un échec ?
            If (resultat < NOTE_PASSAGE) Then
                'Affichage du message d'échec
                e.Row.Cells(10).Text = message
            End If

            'Affichage de la note
            e.Row.Cells(9).Text = Math.Round(resultat).ToString()

        End If
    End Sub


    'Structure contenant les notes
    Private Structure Notes
        Public tp1 As String
        Public tp2 As String
        Public tp3 As String
        Public intra As String
        Public Final As String
    End Structure

End Class
