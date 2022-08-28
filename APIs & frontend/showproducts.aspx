<form id="form1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="serial_no" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="serial_no" HeaderText="serial_no" InsertVisible="False" ReadOnly="True" SortExpression="serial_no" />
            <asp:BoundField DataField="product_name" HeaderText="product_name" SortExpression="product_name" />
            <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
            <asp:BoundField DataField="product_description" HeaderText="product_description" SortExpression="product_description" />
            <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
            <asp:BoundField DataField="final_price" HeaderText="final_price" SortExpression="final_price" />
            <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
            <asp:CheckBoxField DataField="available" HeaderText="available" SortExpression="available" />
            <asp:BoundField DataField="rate" HeaderText="rate" SortExpression="rate" />
            <asp:BoundField DataField="vendor_username" HeaderText="vendor_username" SortExpression="vendor_username" />
            <asp:BoundField DataField="customer_username" HeaderText="customer_username" SortExpression="customer_username" />
            <asp:BoundField DataField="customer_order_id" HeaderText="customer_order_id" SortExpression="customer_order_id" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=desktop-dvecpbc\sqlexpress01;Initial Catalog=milestone2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="ShowProductsbyPrice" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</form>
