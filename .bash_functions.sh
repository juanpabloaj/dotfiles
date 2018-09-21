function git_commit_with_date {
    tempDate=$1

    if [[ "$tempDate" = "" ]]; then
        echo "date string is necessary, ex:"
        echo "${FUNCNAME[0]} '12 hours ago'"
        echo
        return 1
    fi
    tempDate=$(date -R --date="$tempDate")
    GIT_COMMITTER_DATE="$tempDate" git commit --date "$tempDate"
}
