// Autor: Marcos G. Zimmermann
// E-mail: marcos@marcosz.com.br
// Blog: http://marcosz.com.br

function observerTableField(field_id, table_id){
    filterTable(field_id,table_id);
}

function filterTable(field_id,table_id){
    var value = $F(field_id).toLowerCase();
    var rows = $A($A($(table_id).tBodies).first().rows);
    var col = 0;

    if (value.toString().length != 0){
	var re = new RegExp(value);
	var filtered_rows = rows.partition(function(row){
	    var cell = row.cells[col];
	    var cell_value = cell.textContent ? cell.textContent : cell.innerText;
	    return re.test(cell_value.toLowerCase());
	}.bind(this));
	filtered_rows[0].invoke('show');
	filtered_rows[1].invoke('hide');
    }else{
	rows.invoke('show');
    }
}

function pressKeyTableField(keyCode,field_id,table_id) {
    if(keyCode == Event.KEY_RETURN){
	filterTable(field_id,table_id);
    }
}