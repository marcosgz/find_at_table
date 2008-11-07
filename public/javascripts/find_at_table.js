// Autor: Marcos G. Zimmermann
// E-mail: marcos@marcosz.com.br
// Blog: http://marcosz.com.br

function observerTableField(field_id, table_id,cols){
    cols = (typeof cols == "undefined") ? "all" : cols;
    filterTable(field_id,table_id,cols);
}


function filterTable(field_id,table_id,cols){
    var value = $F(field_id).toLowerCase();
    var rows = $A($A($(table_id).tBodies).first().rows);

    if (value.toString().length != 0){
	var re = new RegExp(value);
	var filtered_rows = rows.partition(function(row){
	    var cell_value = getCellValue(row,cols);
	    return re.test(cell_value.toLowerCase());
	}.bind(this));
	filtered_rows[0].invoke('show');
	filtered_rows[1].invoke('hide');
    }else{
	rows.invoke('show');
    }
}

function pressKeyTableField(keyCode,field_id,table_id, cols) {
    if(keyCode == Event.KEY_RETURN){
	cols = (typeof cols == "undefined") ? "all" : cols;
	filterTable(field_id,table_id,cols);
    }
}

function getCellValue(row, cols){
    if (cols == "all"){
	return row.innerHTML.replace(/<[^>]+>/g, "");
    }else{
	var buffer = new StringBuffer();
	cols.sort();
	cols.each(function(col){
	    var cell = row.cells[col];
	    buffer.append(cell.textContent ? cell.textContent : cell.innerText);
	});
	return buffer.toString();
    }
}

function StringBuffer() {
    this.buffer = [];
};

StringBuffer.prototype.append = function append(string) {
    this.buffer.push(string);
    return this;
};

StringBuffer.prototype.toString = function toString() {
    return this.buffer.join("");
};
