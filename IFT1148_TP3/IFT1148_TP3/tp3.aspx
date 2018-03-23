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
            <asp:SqlDataSource ID="SqlDataSourceNotes" runat="server" ConnectionString="<%$ ConnectionStrings:DbNotesConnectString %>" DeleteCommand="DELETE FROM [notes] WHERE [no_etudiant] = ?" InsertCommand="INSERT INTO [notes] ([no_etudiant], [nom], [code_permanent], [section], [tp1], [tp2], [tp3], [intra], [final]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:DbNotesConnectString.ProviderName %>" SelectCommand="SELECT * FROM [notes]" UpdateCommand="UPDATE [notes] SET [nom] = ?, [code_permanent] = ?, [section] = ?, [tp1] = ?, [tp2] = ?, [tp3] = ?, [intra] = ?, [final] = ? WHERE [no_etudiant] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="no_etudiant" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="no_etudiant" Type="Int32" />
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
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="no_etudiant" DataSourceID="SqlDataSourceNotes" ForeColor="#333333" GridLines="None" PageSize="5">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField AccessibleHeaderText="GvBtEdit" ButtonType="Button" EditText="Édition" ShowEditButton="True" />
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
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP1" runat="server" Text='<%# Bind("tp1") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP2" SortExpression="tp2">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteTP2" runat="server" Text='<%# Bind("tp2") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteTP2" runat="server" ControlToValidate="TbNoteTP2" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP2" runat="server" Text='<%# Bind("tp2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TP3" SortExpression="tp3">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteTP3" runat="server" Text='<%# Bind("tp3") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteTP3" runat="server" ControlToValidate="TbNoteTP3" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteTP3" runat="server" Text='<%# Bind("tp3") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Intra" SortExpression="intra">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteIntra" runat="server" Text='<%# Bind("intra") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteIntra" runat="server" ControlToValidate="TbNoteIntra" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteIntra" runat="server" Text='<%# Bind("intra") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Final" SortExpression="final">
                        <EditItemTemplate>
                            <asp:TextBox ID="TbNoteFinal" runat="server" Text='<%# Bind("final") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RfvNoteFinal" runat="server" ControlToValidate="TbNoteFinal" Display="Dynamic" ErrorMessage="Veuillez entrer une note" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LbNoteFinal" runat="server" Text='<%# Bind("final") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField AccessibleHeaderText="GvBtDelete" ButtonType="Button" DeleteText="Supprimer" ShowDeleteButton="True" />
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
        </div>
        <div>            
            <!-- Insertion d'un étudiant -->
        </div>
        <div>            
            <!-- Affichage du rapport -->
        </div>
        <div>            
            <!-- Heure du dernier accées au serveur -->
        </div>
    </form>
</body>
</html>
