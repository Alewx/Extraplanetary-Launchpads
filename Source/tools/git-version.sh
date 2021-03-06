#! /bin/sh

full_version=`./tools/git-version-gen --prefix v .tarball-version`
version=`echo $full_version | sed -e 's/-/\t/' | cut -f 1`

sed -e "s/@FULL_VERSION@/$full_version/" -e "s/@VERSION@/$version/" assembly/AssemblyInfo.in > assembly/AssemblyInfo.cs-

cmp -s assembly/AssemblyInfo.cs assembly/AssemblyInfo.cs- || mv assembly/AssemblyInfo.cs- assembly/AssemblyInfo.cs

rm -f assembly/*.cs-

MAJOR=`echo $full_version | cut -f 1 -d .`
MINOR=`echo $full_version | cut -f 2 -d .`
PATCH=`echo $full_version | cut -f 3 -d .`
BUILD=`echo $full_version | cut -f 4 -d . | cut -f 1 -d '-'`

mkdir -p bin
cat > bin/EL.version <<EOF
{
	"NAME":"Extraplanetary Launchpads",
	"URL":"http://taniwha.org/~bill/EL.version",
	"DOWNLOAD":"http://forum.kerbalspaceprogram.com/threads/59545",
	"VERSION":{"MAJOR":$MAJOR,"MINOR":$MINOR,"PATCH":$PATCH,"BUILD":$BUILD},
	"KSP_VERSION":{"MAJOR":0,"MINOR":90,"PATCH":0}
}
EOF
