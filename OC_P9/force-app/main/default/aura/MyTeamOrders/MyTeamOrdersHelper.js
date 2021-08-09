({
	groupOrders : function(component,rows) {
		var action = component.get("c.SumOdersByOwn");
        action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            let results=response.getReturnValue(); 
            for(var i = 0; i < rows.length; i++)
              {
                var row = rows[i]; 
                for(var key in results) {
                 if (results.hasOwnProperty(key)) {
                     if(row.OwnerName==key)
                     {
                         row.Total=results[key];
                         
                     }
                 }
                }
              }
               component.set("v.orderList", rows);
        }
         
        });
        $A.enqueueAction(action);    
	}
})
