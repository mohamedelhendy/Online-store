<form id="form1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="order_no" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="order_no" HeaderText="order_no" InsertVisible="False" ReadOnly="True" SortExpression="order_no" />
            <asp:BoundField DataField="order_date" HeaderText="order_date" SortExpression="order_date" />
            <asp:BoundField DataField="total_amount" HeaderText="total_amount" SortExpression="total_amount" />
            <asp:BoundField DataField="cash_amount" HeaderText="cash_amount" SortExpression="cash_amount" />
            <asp:BoundField DataField="credit_amount" HeaderText="credit_amount" SortExpression="credit_amount" />
            <asp:BoundField DataField="payment_type" HeaderText="payment_type" SortExpression="payment_type" />
            <asp:BoundField DataField="order_status" HeaderText="order_status" SortExpression="order_status" />
            <asp:BoundField DataField="giftcardcode" HeaderText="giftcardcode" SortExpression="giftcardcode" />
            <asp:BoundField DataField="remaining_days" HeaderText="remaining_days" SortExpression="remaining_days" />
            <asp:BoundField DataField="time_limit" HeaderText="time_limit" SortExpression="time_limit" />
            <asp:BoundField DataField="customer_name" HeaderText="customer_name" SortExpression="customer_name" />
            <asp:BoundField DataField="delivery_id" HeaderText="delivery_id" SortExpression="delivery_id" />
            <asp:BoundField DataField="creditcard_number" HeaderText="creditcard_number" SortExpression="creditcard_number" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=desktop-dvecpbc\sqlexpress01;Initial Catalog=milestone2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [orders] WHERE ([customer_name] = @customer_name)">
        <SelectParameters>
            <asp:SessionParameter Name="customer_name" SessionField="user" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</form>
