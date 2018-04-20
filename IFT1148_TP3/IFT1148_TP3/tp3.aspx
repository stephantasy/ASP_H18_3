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
        <!-- Entête -->  
        <div>          
            <table class="auto-style1">
                <tr>
                    <td style="width:400px;">
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
        
        <!-- AJAX - SCRIPT MANAGER -->
        <asp:ScriptManager ID="ScriptManagerAjax" runat="server"></asp:ScriptManager>
        
        <!-- DATA SOURCES -->
        <div>            
            <!-- SQL DATA SOURCE COMPLET -->
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
            <!-- SQL DATA SOURCE POUR LA SECTION -->
            <asp:SqlDataSource ID="SqlDataSourceSection" runat="server" ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=|DataDirectory|\notes.mdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT DISTINCT [section] FROM [notes]"></asp:SqlDataSource>
        </div>
                        
        <!-- AJAX - Update Panel de la zone Data -->
        <asp:UpdatePanel ID="UpdatePanelAjaxData" runat="server" UpdateMode="Conditional">
            <ContentTemplate>

                <!-- ZONE DATA -->
                <div>
                    <!-- GRIDVIEW DES DONNÉES -->
                    <asp:GridView ID="gvEtudiant" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="no_etudiant" DataSourceID="SqlDataSourceNotes" ForeColor="#333333" GridLines="None" PageSize="5">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:CommandField AccessibleHeaderText="GvBtEdit" ButtonType="Button" EditText="Édition" ShowEditButton="True" CancelText="Annuler" UpdateText="Modifier" />
                            <asp:BoundField DataField="no_etudiant" HeaderText="Numéro" InsertVisible="False" ReadOnly="True" SortExpression="no_etudiant" />
                            <asp:TemplateField HeaderText="Nom étudiant" SortExpression="nom">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNomEtudiant" runat="server" Text='<%# Bind("nom") %>' Columns="20"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvNomEtudiant" runat="server" ControlToValidate="TbNomEtudiant" Display="Dynamic" ErrorMessage="Veuillez entrer un nom" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbNomEtudiant" runat="server" Text='<%# Bind("nom") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Code permanent" SortExpression="code_permanent">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>' Columns="20"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvCodePermanent" runat="server" ControlToValidate="TbCodePermanent" Display="Dynamic" ErrorMessage="Veuillez entrer le code permanent" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RevCodePermanent" runat="server" ControlToValidate="TbCodePermanent" Display="Dynamic" ErrorMessage="Le code permanent doit être au format ABCD12345678" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression="[a-zA-Z]{4}[0-9]{8}"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbCodePermanent" runat="server" Text='<%# Bind("code_permanent") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Section" SortExpression="section">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceSection" DataTextField="section" DataValueField="section" SelectedValue='<%# Bind("section") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("section") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TP1" SortExpression="tp1">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNoteTP1" runat="server" Text='<%# Bind("tp1") %>' Columns="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvNoteTP1" runat="server" ControlToValidate="TbNoteTP1" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvNoteTp1" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP1" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbNoteTP1" runat="server" Text='<%# Bind("tp1") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TP2" SortExpression="tp2">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNoteTP2" runat="server" Text='<%# Bind("tp2") %>' Columns="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvNoteTP2" runat="server" ControlToValidate="TbNoteTP2" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvNoteTp2" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP2" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbNoteTP2" runat="server" Text='<%# Bind("tp2") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TP3" SortExpression="tp3">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNoteTP3" runat="server" Text='<%# Bind("tp3") %>' Columns="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvNoteTP3" runat="server" ControlToValidate="TbNoteTP3" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvNoteTp3" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteTP3" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbNoteTP3" runat="server" Text='<%# Bind("tp3") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Intra" SortExpression="intra">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNoteIntra" runat="server" Text='<%# Bind("intra") %>' Columns="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvNoteIntra" runat="server" ControlToValidate="TbNoteIntra" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvNoteIntra" runat="server" ClientValidationFunction="customClientValidation" ControlToValidate="TbNoteIntra" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LbNoteIntra" runat="server" Text='<%# Bind("intra") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Final" SortExpression="final">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TbNoteFinal" runat="server" Text='<%# Bind("final") %>' Columns="5"></asp:TextBox>
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
           
                    <!-- Heure du dernier rafaichissement du GridView -->
                    <div>
                        <asp:Label ID="lbHeureZoneDataMsg" runat="server" Text="Données rafraîchies le : "></asp:Label><asp:Label ID="lbHeureZoneData" runat="server"></asp:Label>
                    </div>

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
                            <asp:TemplateField HeaderText="Section" SortExpression="section">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceSection" DataTextField="section" DataValueField="section" SelectedValue='<%# Bind("section") %>'>
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("section") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
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

                    <!-- Bouton d'insertion d'un étudiant -->
                    <asp:Button ID="btInserer" runat="server" Text="Insérer un étudiant" OnClick="BtInsererClicked" />

                </div>
            </ContentTemplate>
        </asp:UpdatePanel><!-- AJAX - Fin Update Panel -->


        <!-- AJAX - Update Panel de la zone Rapport -->
        <asp:UpdatePanel ID="UpdatePanelAjaxRapport" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <!-- ZONE DU RAPPORT -->
                <div>                        
                    <!-- Bouton d'affichage du rapport -->
                    <asp:Button ID="btRapport" runat="server" Text="Afficher le rapport" />

                    <!-- AJAX - Message d'attente lors de la mise à jour -->
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanelAjaxRapport" DisplayAfter="150">
                        <ProgressTemplate>
                            <h1>Patientez, construction du rapport...</h1>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
            
                    <!-- GRIDVIEW  du rapport -->
                    <asp:GridView ID="gvRapport" runat="server" Visible="False" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="no_etudiant" DataSourceID="SqlDataSourceNotes" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="no_etudiant" HeaderText="Numéro" InsertVisible="False" ReadOnly="True" SortExpression="no_etudiant" />
                            <asp:BoundField DataField="nom" HeaderText="Nom étudiant" SortExpression="nom" />
                            <asp:BoundField DataField="code_permanent" HeaderText="Code permanent" SortExpression="code_permanent" />
                            <asp:BoundField DataField="section" HeaderText="Section" SortExpression="section" />
                            <asp:BoundField DataField="tp1" HeaderText="TP 1" SortExpression="tp1" />
                            <asp:BoundField DataField="tp2" HeaderText="TP 2" SortExpression="tp2" />
                            <asp:BoundField DataField="tp3" HeaderText="TP 3" SortExpression="tp3" />
                            <asp:BoundField DataField="intra" HeaderText="Intra" SortExpression="intra" />
                            <asp:BoundField DataField="final" HeaderText="Final" SortExpression="final" />
                            <asp:TemplateField HeaderText="Note finale"></asp:TemplateField>
                            <asp:TemplateField HeaderText="Message">
                                <ItemStyle ForeColor="#CC0000" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />
                    </asp:GridView>
         
                    <!-- Heure de du dernier affichage du rapport (côté client) -->
                    <div>
                        <asp:Label ID="lbHeureZoneRapportMsg" runat="server" Text="Rapport affiché le : "></asp:Label><asp:Label ID="lbHeureZoneRapport" runat="server" Text=""></asp:Label>            
                    </div>
                </div>
                
            </ContentTemplate>
        </asp:UpdatePanel><!-- AJAX - Fin Update Panel -->
    </form>
</body>
</html>
