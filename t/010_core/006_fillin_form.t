use strict;
use warnings;
use HTML::Shakan;
use Test::More tests => 3;
use CGI;

sub trim {
    local $_ = shift;
    s/\n$//;
    $_;
}

do {
    my $form = HTML::Shakan->new(
        request => CGI->new({yay => 3}),
        fields => [
            TextField(name => 'yay')
        ],
    );
    is $form->render, '<label for="id_yay">yay</label><input id="id_yay" name="yay" type="text" value="3" />';
};

do {
    my $form = HTML::Shakan->new(
        request => CGI->new({yay => 'b'}),
        fields => [
            ChoiceField(name => 'yay', choices => [
                a => 1,
                b => 2,
            ])
        ],
    );
    is $form->render, trim(<<'...');
<label for="id_yay">yay</label><select id="id_yay" name="yay">
<option value="a">1</option>
<option value="b" selected="selected">2</option>
</select>
...
};

do {
    my $form = HTML::Shakan->new(
        request => CGI->new({yay => 'b'}),
        fields => [
            ChoiceField(
                widget => 'radio',
                name => 'yay',
                choices => [
                    a => 1,
                    b => 2,
                ]
            )
        ],
    );
    is $form->render, trim(<<'...');
<label for="id_yay">yay</label><ul>
<li><label><input name="yay" type="radio" value="a" />1</label></li>
<li><label><input name="yay" type="radio" value="b" checked="checked" />2</label></li>
</ul>
...
};

