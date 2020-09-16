package Cx

SupportedResources = "$.resource.aws_s3_bucket_public_access_block"

#default of block_public_acls is false
CxPolicy [ result ] {
    pubACL := input.document[i].resource.aws_s3_bucket_public_access_block[name]
    object.get(pubACL, "block_public_acls", "not found") == "not found"

    result := {
                "foundKye": 		pubACL,
                "fileId": 			input.document[i].id,
                "fileName": 	    input.document[i].file,
                "lineSearchKey": 	concat("+", ["aws_s3_bucket_public_access_block", name]),
                "issueType":		"MissingAttribute",
                "keyName":			"block_public_acls",
                "keyExpectedValue": true,
                "keyActualValue": 	null,
                #{metadata}
              }
}

CxPolicy [ result ] {
	pubACL := input.document[i].resource.aws_s3_bucket_public_access_block[name]
    pubACL.block_public_acls == false

    result := {
                "foundKye": 		pubACL,
                "fileId": 			input.document[i].id,
                "fileName": 	    input.document[i].file,
                "lineSearchKey": 	[concat("+", ["aws_s3_bucket_public_access_block", name]), "block_public_acls"],
                "issueType":		"MissingAttribute",
                "keyName":			"block_public_acls",
                "keyExpectedValue": true,
                "keyActualValue": 	false,
                #{metadata}
              }
}
