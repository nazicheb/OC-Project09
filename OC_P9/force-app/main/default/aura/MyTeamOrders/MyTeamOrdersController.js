({
    init : function(component, event, helper) {
        
        
       component.set('v.mycolumns', [
           {label: "Order Number",fieldName:"OrderNumber",type:"Auto Number"},
           {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
           {label: 'Status', fieldName: 'Status', type: 'text'},
           {label: 'Order Amount', fieldName: 'TotalAmount', type: 'currency'},
           {label: 'Total Amount per Owner', fieldName: 'Total', type: 'currency'},
           {label: 'Order Owner', fieldName: 'OwnerName', type: 'text'}
            ]);
        var action = component.get("c.fetchOrders");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
               var rows = response.getReturnValue();
               for ( var i = 0; i < rows.length; i++ ) {
                  var row = rows[i];
                  if ( row.Account ) {
                        row.AccountName = row.Account.Name;
                  }
                 if(row.Owner){
                      row.OwnerName = row.Owner.Name;
                 }
               }
               
                helper.groupOrders(component,rows);
            }
        });
        $A.enqueueAction(action);
    }
    

})