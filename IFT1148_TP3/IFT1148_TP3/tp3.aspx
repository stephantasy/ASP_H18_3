<%@ Page Language="VB" AutoEventWireup="false" CodeFile="tp3.aspx.vb" Inherits="tp3" %>

<!-- 
    IFT1148 - TP3
    Stéphane Barthélemy
    20084771 - barthste
 -->

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IFT1148 - TP3</title>
    <!-- Javascript pour la validation (fichier externe) -->	
    <script type="text/javascript" src="javascript.js?v=3"></script>
    <!-- Style -->
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        h1{
            font-weight:bold;
            color:darkblue;
        }
        p{
            font-weight:bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- Entête -->            
            <table class="auto-style1">
                <tr>
                    <td>
                        <h1>Saisie des notes</h1>
                    </td>
                    <td>
                        <p>
                            <span>Cours IFT1148 - Travail pratique #3</span><br/>
                            <span>Par Stéphane Barthélemy (BARS11017704)</span><br/>
                            <span>Login : barthste</span>
                        </p>
                    </td>
                </tr>
            </table>               
        </div>
        <div>
            <!-- SQL DATA SOURCE -->
            <asp:SqlDataSource ID="SqlDataSourceNotes" runat="server" ConnectionString="<%$ ConnectionStrings:DbNotesConnectString %>" ProviderName="<%$ ConnectionStrings:DbNotesConnectString.ProviderName %>" 
                    DeleteCommand="DELETE FROM [notes] WHERE [no_etudiant] = ?" 
                    InsertCommand="INSERT INTO [notes] ([nom], [code_permanent], [section], [tp1], [tp2], [tp3], [intra], [final]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
                    SelectCommand="SELECT * FROM [notes]" UpdateCommand="UPDATE [notes] SET [nom] = ?, [code_permanent] = ?, [section] = ?, [tp1] = ?, [tp2] = ?, [tp3] = ?, [intra] = ?, [final] = ? WHERE [no_etudiant] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="no_etudiant" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="nom" Type="String" />
                    <asp:Parameter Name="code_permanent" Type="String" />
                    <asp:Parameter Name="section" Type="String" />
                    <asp:Parameter Name="tp1" Type="String" />
                    <asp:Parameter Name="tp2" Type="String" />
                    <asp:Parameter Name="tp3" Type="String" />
                    <asp:Parameter Name="intra" Type="String" />
                    <asp:Parameter Name="final" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nom" Type="String" />
                    <asp:Parameter Name="code_permanent" Type="String" />
                    <asp:Parameter Name="section" Type="String" />
                    <asp:Parameter Name="tp1" Type="String" />
                    <asp:Parameter Name="tp2" Type="String" />
                    <asp:Parameter Name="tp3" Type="String" />
                    <asp:Parameter Name="intra" Type="String" />
                    <asp:Parameter Name="final" Type="String" />
                    <asp:Parameter Name="no_etudiant" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div>
            <!-- GRIDVIEW -->
            <asp:GridView ID="gvEtudiant" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="no_etudiant" DataSourceID="SqlDataSourceNotes" ForeColor="#333333" GridLines="None" PageSize="5">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField AccessibleHeaderText="GvBtEdit" ButtonType="Button" EditText="Édition" ShowEditButton="True" CancelText="Annuler" UpdateText="Modifier" />
                    <asp:BoundField DataField="no_etudiant" HeaderText="Numéro" InsertVisible="False" ReadOnly="True" SortExpression="no_etudiant" />
                    <asp:TemplateField HeaderText="Nom étudiant" SortExpression="nom">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNomEtudiant" runat="server" Text='<%# Bind("nom") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNomEtudiant" runat="server" ControlToValidate="TbNomEtudiant" Display="Dynamic" ErrorMessage="Veuillez entrer un nom" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNomEtudiant" runat="server" Text='<%# Bind("nom") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Code permanent" SortExpression="code_permanent">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvCodePermanent" runat="server" ControlToValidate="TbCodePermanent" Display="Dynamic" ErrorMessage="Veuillez entrer le code permanent" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RevCodePermanent" runat="server" ControlToValidate="TbCodePermanent" Display="Dynamic" ErrorMessage="Le code permanent doit être au format ABCD12345678" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="[a-zA-Z]{4}[0-9]{8}"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="section" HeaderText="Section" SortExpression="section" />
                    <asp:TemplateField HeaderText="TP1" SortExpression="tp1">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteTP1" runat="server" Text='<%# Bind("tp1") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteTP1" runat="server" ControlToValidate="TbNoteTP1" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvNoteTp1" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP1" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP1" runat="server" Text='<%# Bind("tp1") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP2" SortExpression="tp2">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteTP2" runat="server" Text='<%# Bind("tp2") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteTP2" runat="server" ControlToValidate="TbNoteTP2" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvNoteTp2" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP2" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP2" runat="server" Text='<%# Bind("tp2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP3" SortExpression="tp3">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteTP3" runat="server" Text='<%# Bind("tp3") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteTP3" runat="server" ControlToValidate="TbNoteTP3" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvNoteTp3" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP3" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP3" runat="server" Text='<%# Bind("tp3") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Intra" SortExpression="intra">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteIntra" runat="server" Text='<%# Bind("intra") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteIntra" runat="server" ControlToValidate="TbNoteIntra" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvNoteIntra" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteIntra" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteIntra" runat="server" Text='<%# Bind("intra") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Final" SortExpression="final">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteFinal" runat="server" Text='<%# Bind("final") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteFinal" runat="server" ControlToValidate="TbNoteFinal" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvNoteFinal" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteFinal" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteFinal" runat="server" Text='<%# Bind("final") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField AccessibleHeaderText="GvBtDelete" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="gvBtDelete" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm(&quot;Êtes-vous certain de vouloir supprimer cette ligne ?&quot;);" Text="Supprimer" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </div>
        <div>            
            <!-- Heure de la dernière modification de la page -->
            <asp:Label ID="lbHeureModifPage" runat="server" Text="Heure de la dernière modification de la page"><% =Now() %></asp:Label>
        </div>
        <div>            
            <!-- DetailsView : caché au démarrage -->
            <asp:DetailsView ID="dvInsertion" runat="server" Visible="False" AutoGenerateRows="False" DataKeyNames="no_etudiant" DataSourceID="SqlDataSourceNotes" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:CommandField ButtonType="Button" CancelText="Annuler" InsertText="Insérer" ShowInsertButton="True" />
                    <asp:TemplateField HeaderText="Nom étudiant" SortExpression="nom">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditNom" runat="server" Text='<%# Bind("nom") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertNom" runat="server" Text='<%# Bind("nom") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertNom" runat="server" ControlToValidate="tbDvInsertNom" Display="Dynamic" ErrorMessage="Veuillez entrer un nom" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvNom" runat="server" Text='<%# Bind("nom") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Code permanent" SortExpression="code_permanent">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertCodePermanent" runat="server" ControlToValidate="tbDvInsertCodePermanent" Display="Dynamic" ErrorMessage="Veuillez entrer le code permanent" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RevCodePermanent" runat="server" ControlToValidate="tbDvInsertCodePermanent" Display="Dynamic" ErrorMessage="Le code permanent doit être au format ABCD12345678" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="[a-zA-Z]{4}[0-9]{8}"></asp:RegularExpressionValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="section" HeaderText="Section" SortExpression="section" />
                    <asp:TemplateField HeaderText="TP1" SortExpression="tp1">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditTp1" runat="server" Text='<%# Bind("tp1") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertTp1" runat="server" Text='<%# Bind("tp1") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertTp1" runat="server" ControlToValidate="tbDvInsertTp1" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvInsertTp1" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="tbDvInsertTp1" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvTp1" runat="server" Text='<%# Bind("tp1") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP2" SortExpression="tp2">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditTp2" runat="server" Text='<%# Bind("tp2") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertTp2" runat="server" Text='<%# Bind("tp2") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertTp2" runat="server" ControlToValidate="tbDvInsertTp2" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvInsertTp2" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="tbDvInsertTp2" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvTp2" runat="server" Text='<%# Bind("tp2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP3" SortExpression="tp3">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditTp3" runat="server" Text='<%# Bind("tp3") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertTp3" runat="server" Text='<%# Bind("tp3") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertTp3" runat="server" ControlToValidate="tbDvInsertTp3" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvInsertTp3" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="tbDvInsertTp3" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvTp3" runat="server" Text='<%# Bind("tp3") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Intra" SortExpression="intra">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditIntra" runat="server" Text='<%# Bind("intra") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertIntra" runat="server" Text='<%# Bind("intra") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertIntra" runat="server" ControlToValidate="tbDvInsertIntra" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvInsertIntra" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="tbDvInsertIntra" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvIntra" runat="server" Text='<%# Bind("intra") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Final" SortExpression="final">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDvEditFinal" runat="server" Text='<%# Bind("final") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tbDvInsertFinal" runat="server" Text='<%# Bind("final") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvInsertFinal" runat="server" ControlToValidate="tbDvInsertFinal" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvInsertFinal" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="tbDvInsertFinal" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDvFinal" runat="server" Text='<%# Bind("final") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
        </div>
        <div>            
            <!-- Bouton d'insertion d'un étudiant -->
            <asp:Button ID="btInserer" runat="server" Text="Insérer un étudiant" OnClick="BtInsererClicked" />
        </div>
        <div>            
            <!-- Bouton d'affichage du rapport -->
            <asp:Button ID="btRapport" runat="server" Text="Afficher le rapport" />
            <asp:Label ID="lbPatienter" runat="server" Text="<h1>Patientez, construction du rapport...</h1>" Visible="False"></asp:Label>
            <asp:GridView ID="gvRapport" runat="server" Visible="False">
            </asp:GridView>
        </div>
        <div>            
            <!-- Heure du dernier accées au serveur -->
            <asp:Label ID="lbHeureAccesServeur" runat="server" Text="Heure du dernier accès au serveur"><% =Now() %></asp:Label>
        </div>
    </form>
</body>
</html>
