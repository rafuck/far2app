#!/usr/bin/env bash
APP=Far.app
ROOT=$( cd "$(dirname "${0}")" >/dev/null 2>&1 ; pwd -P )

if [ "$#" -ne 1 ]; then
    echo "App folder is not defined";
    exit 1;
fi

if [ ! -d ${1} ]; then
	echo "App folder is not exists";
	exit 1;
fi

PACKAGE=$(cd ${1} && pwd)

if [ ! -f ${PACKAGE}/bin/far2l ]; then
	echo "${1}/bin/far2l is not exists";
	exit 1;
fi

test ${APP} && rm -rf ${APP}
DIR=${APP}/Contents/MacOS
mkdir -p ${DIR} && cd ${DIR}

cp -r ${PACKAGE}/* ./
cat >Far <<EOL
#!/usr/bin/env bash
ROOT="\$( cd "\$(dirname "\$0")" >/dev/null 2>&1 ; pwd -P )"
\${ROOT}/bin/far2l & 
EOL
chmod a+x Far

cp -R ${ROOT}/Contents/* ../