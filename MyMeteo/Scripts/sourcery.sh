#!/bin/sh

BASE_DIRECTORY="MyMeteo"

mkdir -p ${BASE_DIRECTORY}Tests/Generated/

./Pods/Sourcery/bin/sourcery \
	--sources $BASE_DIRECTORY \
	--templates ./SourceryTemplates/AutoMockable.stencil \
    --output ${BASE_DIRECTORY}Tests/Generated/ \
	--args module=$BASE_DIRECTORY