
'   IFT1148 -TP3
'   Stéphane Barthélemy
'   20084771 - barthste

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


    ' DEBUG : Tentative de cacher le bouton Supprimer lors de l'édition de la GridView
    Dim popo As Boolean = False
    Private Sub gvEtudiant_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvEtudiant.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'If Session("gvEtudiant") IsNot Nothing Then
            'If e.Row.Then Then
            'Dim btDelete As Button = DirectCast(e.Row.FindControl("gvBtDelete"), Button)
            'btDelete.Visible = False
            'End If
        End If
        popo = False
    End Sub
    Private Sub gvEtudiant_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvEtudiant.RowEditing

        Dim lb As Button
        'lb = CType(e.NewEditIndex., Button)     'Row.FindControl("gvBtDelete")
        'gvEtudiant.mode
        Dim i As Integer
        i = 0
        popo = True
    End Sub


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

End Class
