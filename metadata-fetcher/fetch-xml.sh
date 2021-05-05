#!/bin/bash

BACKUP_SUFFIX=".bak"
XMLSECTOOL="/opt/xmlsectool/xmlsectool.sh"

if [ -z "$UPDATE_INTERVAL" ]; then
    UPDATE_INTERVAL="1000"
fi

if [ -z "$DESTINATION" ]; then
    DESTINATION="/var/lib/metadata"
fi

# ########################################################################
#
# Logging
#
# ########################################################################

LOG_ERROR=1
LOG_WARN=2
LOG_DEBUG=3

LOG_DATE="%Y-%m-%dT%H:%M:%S"

act_log_level="$LOG_DEBUG"

log_level ()
{
    level="$1"; shift
    if [ "$level" -eq "$LOG_ERROR" ]; then
        echo "ERROR";
    elif [ "$level" -eq "$LOG_WARN" ]; then
        echo "WARN";
    elif [ "$level" -eq "$LOG_DEBUG" ]; then
        echo "DEBUG";
    else
        echo "-UNKNOWN-"
    fi
}

log ()
{
    level="$1"; shift

    if ((act_log_level >= level)); then
        echo "$(date +$LOG_DATE) $(log_level $level) $*"
    fi
}

# ########################################################################

workdir=""
path="$(pwd)"

# ########################################################################

clean_up ()
{
    cd $path
    if [ -n "$workdir" ]; then
        rm -rf "$workdir"
    fi
}

trap clean_up EXIT

workdir=$(mktemp --directory fetch-xml-XXXXXX)
cd $workdir
log $LOG_DEBUG "using working directory $workdir"

# ########################################################################

download () {
    url="$1"
    curl --silent --remote-name --location --write-out "%{filename_effective}" "$url"
}

verify () {
    local filename="$1"
    local cert="$2"

    log $LOG_DEBUG "verifing signature of '$filename' with '$cert'"
    $XMLSECTOOL --verifySignature --inFile "$filename" --certificate "$cert"
}

copy_file () {
    local filename="$1"
    local destination="$2"

    base=$(basename $filename)
    dest_file="$destination/$base"

    if [ -f "$dest_file" ]; then
        log $LOG_DEBUG "create backup copy of $dest_file"
        cp "$dest_file" "${dest_file}${BACKUP_SUFFIX}"
    fi

    log $LOG_DEBUG "copying $filename to $dest_file"
    mv $filename "$dest_file"
}

generate_metadata () {
    local filename="$1"
    local entityId="$2"

    local md_file="$(echo -n "$entityId" | openssl sha1 | grep -oE '[0-9a-f]{40}').xml"

    xmlstarlet select -N 'xn=urn:oasis:names:tc:SAML:2.0:metadata' --template --copy-of "//xn:EntityDescriptor[@entityID='$entityId']" $filename > "$md_file"
    echo $md_file
}

update_metadata () {
    local url="$1"; shift
    local crt="$1"; shift
    local dst="$1"; shift

    local filename=$(download "$url")
    if [ "$?" != "0" ]; then
        log $LOG_WARN "could not download \`$url', skipping"
        return 1
    fi

    log $LOG_DEBUG "downloaded file: $filename"

    if ! verify $filename $crt; then
        log $LOG_WARN "could not verify the signature of \`$filename', deleting"
        rm $filename
        return 1
    fi

    for idp in $*; do
        md_file=$(generate_metadata "$filename" "$idp")
        copy_file "$md_file" "$dst"
    done
}

# ########################################################################

while [ 1 ]; do

    update_metadata "https://pub.federation.renater.fr/metadata/renater/main/main-idps-renater-metadata.xml" \
                    "/opt/fetch/renater-metadata-signing-cert-2016.pem" \
                    "$DESTINATION" \
                    "urn:mace:cru.fr:federation:unice.fr"

    update_metadata "https://pub.federation.renater.fr/metadata/edugain/main/main-idps-edugain-metadata.xml" \
                    "/opt/fetch/renater-metadata-signing-cert-2016.pem" \
                    "$DESTINATION" \
                    "https://idp.mci4me.at/idp/shibboleth" \
                    "https://www.rediris.es/sir/usidp" \
                    "https://idp.haaga-helia.fi/idp/shibboleth" \
                    "https://unigepass.unige.it/idp" \
                    "https://idp.tuke.sk/idp/shibboleth"

    sleep $UPDATE_INTERVAL
done

