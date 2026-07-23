enum PinesDatePickerState {
    static func xData(format: String) -> String {
        """
        {
            datePickerOpen: false,
            datePickerValue: '',
            datePickerFormat: '\(format)',
            datePickerMonth: '',
            datePickerYear: '',
            datePickerDay: '',
            datePickerDaysInMonth: [],
            datePickerBlankDaysInMonth: [],
            datePickerMonthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            datePickerDays: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            datePickerDayClicked(day) {
                let selectedDate = new Date(this.datePickerYear, this.datePickerMonth, day);
                this.datePickerDay = day;
                this.datePickerValue = this.datePickerFormatDate(selectedDate);
                this.datePickerIsSelectedDate(day);
                this.datePickerOpen = false;
            },
            datePickerPreviousMonth(){
                if (this.datePickerMonth == 0) {
                    this.datePickerYear--;
                    this.datePickerMonth = 12;
                }
                this.datePickerMonth--;
                this.datePickerCalculateDays();
            },
            datePickerNextMonth(){
                if (this.datePickerMonth == 11) {
                    this.datePickerMonth = 0;
                    this.datePickerYear++;
                } else {
                    this.datePickerMonth++;
                }
                this.datePickerCalculateDays();
            },
            datePickerIsSelectedDate(day) {
                const d = new Date(this.datePickerYear, this.datePickerMonth, day);
                return this.datePickerValue === this.datePickerFormatDate(d) ? true : false;
            },
            datePickerIsToday(day) {
                const today = new Date();
                const d = new Date(this.datePickerYear, this.datePickerMonth, day);
                return today.toDateString() === d.toDateString() ? true : false;
            },
            datePickerCalculateDays() {
                let daysInMonth = new Date(this.datePickerYear, this.datePickerMonth + 1, 0).getDate();
                let dayOfWeek = new Date(this.datePickerYear, this.datePickerMonth).getDay();
                let blankdaysArray = [];
                for (var i = 1; i <= dayOfWeek; i++) {
                    blankdaysArray.push(i);
                }
                let daysArray = [];
                for (var i = 1; i <= daysInMonth; i++) {
                    daysArray.push(i);
                }
                this.datePickerBlankDaysInMonth = blankdaysArray;
                this.datePickerDaysInMonth = daysArray;
            },
            datePickerFormatDate(date) {
                let formattedDay = this.datePickerDays[date.getDay()];
                let formattedDate = ('0' + date.getDate()).slice(-2);
                let formattedMonth = this.datePickerMonthNames[date.getMonth()];
                let formattedMonthShortName = this.datePickerMonthNames[date.getMonth()].substring(0, 3);
                let formattedMonthInNumber = ('0' + (parseInt(date.getMonth()) + 1)).slice(-2);
                let formattedYear = date.getFullYear();
                if (this.datePickerFormat === 'M d, Y') {
                    return `${formattedMonthShortName} ${formattedDate}, ${formattedYear}`;
                }
                if (this.datePickerFormat === 'MM-DD-YYYY') {
                    return `${formattedMonthInNumber}-${formattedDate}-${formattedYear}`;
                }
                if (this.datePickerFormat === 'DD-MM-YYYY') {
                    return `${formattedDate}-${formattedMonthInNumber}-${formattedYear}`;
                }
                if (this.datePickerFormat === 'YYYY-MM-DD') {
                    return `${formattedYear}-${formattedMonthInNumber}-${formattedDate}`;
                }
                if (this.datePickerFormat === 'D d M, Y') {
                    return `${formattedDay} ${formattedDate} ${formattedMonthShortName} ${formattedYear}`;
                }
                return `${formattedMonth} ${formattedDate}, ${formattedYear}`;
            },
        }
        """
    }

    static var xInit: String {
        """
        currentDate = new Date();
        if (datePickerValue) {
            currentDate = new Date(Date.parse(datePickerValue));
        }
        datePickerMonth = currentDate.getMonth();
        datePickerYear = currentDate.getFullYear();
        datePickerDay = currentDate.getDay();
        datePickerValue = datePickerFormatDate( currentDate );
        datePickerCalculateDays();
        """
    }
}
