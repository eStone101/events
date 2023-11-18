package Events::Http::Controllers::Controller;

use Events::Actions::CreateEvent;
use Events::Repositories::EventRepository;

use strict;
use warnings;

use Foundation::Appify;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub welcome {
    my $self = shift;
    my $request = shift;

    app()->pushToStack('scripts', servicePath('events') . '/script.js');

    my $EventRepository = Events::Repositories::EventRepository->new();
    my $upcomingEvents =  $EventRepository->getUpcomingEvents();

    my $template = &_::template('events::welcome', {
        events => $upcomingEvents,
        isAdmin => user()->isAdmin(),
        adminRoute => '/apps/events/admin',
    });

    return $template->output();
}

sub dashboard {
    my $self = shift;
    my $request = shift;

    my $file = '/home/vagrant/sites/cosmoservices.test/services/events/src/Events/eventTemplates.json';
    my $templateData = app()->readJson($file);
    my @templates;
    unless (-f $file) {
        return '';
    }

    foreach my $key (keys %$templateData)
    {
        push(@templates,{key => $key, name => $templateData->{$key}->{'name'}});
    }
    my $template = &_::template('events::dashboard', {
        templates => \@templates,
        isAdmin => user()->get('eventAdmin'),
    });

    return $template->output();

    return '';
}

sub show {
    my $self = shift;
    my $request = shift;

    my @params;
    push (@params, 'id', $request->{param}->{id});
    my $EventRepository = Events::Repositories::EventRepository->new();
    my $event =  $EventRepository->get(\@params);

    my $template = &_::template('events::show', {
        date => $event->{date},
        type => $event->{type},
        id => $event->{id},
        location => $event->{location}
    });

    return $template->output();
}

# sub show {
#     my $self = shift;
#     my $request = shift;



#     my $template = &_::template('events::show', {
#     });

#     return $template->output();
# }

1;
