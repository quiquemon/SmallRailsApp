module TeamHelper
	def spanish_date(date)
		months = {
			'01' => 'Enero',
			'02' => 'Febrero',
			'03' => 'Marzo',
			'04' => 'Abril',
			'05' => 'Mayo',
			'06' => 'Junio',
			'07' => 'Julio',
			'08' => 'Agosto',
			'09' => 'Septiembre',
			'10' => 'Octubre',
			'11' => 'Noviembre',
			'12' => 'Diciembre'
		}
		
		date_array = date.to_s.split('-');
		"#{date_array[2]} de #{months[date_array[1]]} de #{date_array[0]}"
	end
end