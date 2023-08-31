package vpc


# simple SPV rule
# Date Range, update flag, notifyOption, threshold amount

# transaction date, current balance, spend limit amount, threshold amount, notifyOption, date range
# we should return remaning balance, count of transactions left for SPV rule

default spv = false

spv = response {
	
	mainRule
	response := {
        "balance": Balance,
		"availableTransactions": Transactioncount
    }
	
}

mainRule {
	#start date of transaction should be valid
	somevar := time.parse_rfc3339_ns(input.rule.startDate)
	print(somevar)
	time.parse_rfc3339_ns(input.transaction.date) >= time.parse_rfc3339_ns(input.rule.startDate)
	# end date of transaction should be valid
	time.parse_rfc3339_ns(input.transaction.date) <= time.parse_rfc3339_ns(input.rule.endDate)

	#current balance should be greater than threshold
	input.transaction.balance > (input.rule.thresholdAmount * input.rule.spendLimitAmount)/100

	#print(input.transaction.count)
	input.transaction.count < input.rule.maxAuth
}

Balance[resp] {
    mainRule == true
	newbalance:= input.transaction.balance-input.transaction.amount
    resp := newbalance
}

Transactioncount[resp] {
    mainRule == true
	newtransactionCount:= input.transaction.count-1
    resp := newtransactionCount
}



