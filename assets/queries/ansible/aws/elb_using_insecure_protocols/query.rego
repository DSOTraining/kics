package Cx

import data.generic.ansible as ansLib

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_application_lb"]

	object.get(elb, "listeners", "undefined") == "undefined"

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_application_lb}}", [task.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "community.aws.elb_application_lb.listeners is defined",
		"keyActualValue": "community.aws.elb_application_lb.listeners is undefined",
	}
}

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_application_lb"]

	object.get(elb.listeners[j], "SslPolicy", "undefined") == "undefined"

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_application_lb}}.listeners.%s", [task.name, j]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "community.aws.elb_application_lb.listeners.SslPolicy is defined",
		"keyActualValue": "community.aws.elb_application_lb.listeners.SslPolicy is undefined",
	}
}

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_application_lb"]

	check_vulnerability(elb.listeners[j].SslPolicy)

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_application_lb}}.listeners.%s", [task.name, j]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "community.aws.elb_application_lb.listeners.SslPolicy is not a weak cipher",
		"keyActualValue": "community.aws.elb_application_lb.listeners.SslPolicy is a weak cipher",
	}
}

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_network_lb"]

	object.get(elb, "listeners", "undefined") == "undefined"

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_network_lb}}", [task.name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "community.aws.elb_network_lb.listeners is defined",
		"keyActualValue": "community.aws.elb_network_lb.listeners is undefined",
	}
}

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_network_lb"]

	object.get(elb.listeners[j], "SslPolicy", "undefined") == "undefined"

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_network_lb}}.listeners.%s", [task.name, j]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "community.aws.elb_network_lb.listeners.SslPolicy is defined",
		"keyActualValue": "community.aws.elb_network_lb.listeners.SslPolicy is undefined",
	}
}

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	elb := task["community.aws.elb_network_lb"]

	check_vulnerability(elb.listeners[j].SslPolicy)

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{community.aws.elb_network_lb}}.listeners.%s", [task.name, j]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "community.aws.elb_network_lb.listeners.SslPolicy is not a weak cipher",
		"keyActualValue": "community.aws.elb_network_lb.listeners.SslPolicy is a weak cipher",
	}
}

check_vulnerability(val) {
	insecure_protocols = {"Protocol-SSLv2", "Protocol-SSLv3", "Protocol-TLSv1", "Protocol-TLSv1.1"}
	val == insecure_protocols[_]
}
